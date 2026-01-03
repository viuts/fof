package database

import (
	"context"
	"fmt"
	"net/url"
	"strings"
	"time"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

// Client represents a database client with GORM
type Client struct {
	DB *gorm.DB
}

// Config holds database configuration
type Config struct {
	Host     string
	Port     string
	User     string
	Password string
	DBName   string
	SSLMode  string
}

// ParseDatabaseURL parses a connection string into a Config struct
func ParseDatabaseURL(dbURL string) (Config, error) {
	u, err := url.Parse(dbURL)
	if err != nil {
		return Config{}, fmt.Errorf("failed to parse database URL: %w", err)
	}

	if u.Scheme != "postgres" && u.Scheme != "postgresql" {
		return Config{}, fmt.Errorf("invalid scheme: %s", u.Scheme)
	}

	cfg := Config{}
	cfg.User = u.User.Username()
	cfg.Password, _ = u.User.Password()
	cfg.Host = u.Hostname()
	cfg.Port = u.Port()
	if cfg.Port == "" {
		cfg.Port = "5432"
	}
	cfg.DBName = strings.TrimPrefix(u.Path, "/")
	cfg.SSLMode = u.Query().Get("sslmode")
	if cfg.SSLMode == "" {
		cfg.SSLMode = "disable"
	}

	return cfg, nil
}

// NewClient creates a new GORM database client
func NewClient(cfg Config) (*Client, error) {
	dsn := fmt.Sprintf(
		"host=%s port=%s user=%s password=%s dbname=%s sslmode=%s",
		cfg.Host, cfg.Port, cfg.User, cfg.Password, cfg.DBName, cfg.SSLMode,
	)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Info),
		NowFunc: func() time.Time {
			return time.Now().UTC()
		},
	})
	if err != nil {
		return nil, fmt.Errorf("failed to connect to database: %w", err)
	}

	// Get underlying SQL DB for connection pool configuration
	sqlDB, err := db.DB()
	if err != nil {
		return nil, fmt.Errorf("failed to get underlying database: %w", err)
	}

	// Configure connection pool
	sqlDB.SetMaxOpenConns(25)
	sqlDB.SetMaxIdleConns(5)
	sqlDB.SetConnMaxLifetime(5 * time.Minute)
	sqlDB.SetConnMaxIdleTime(10 * time.Minute)

	// Verify connection
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := sqlDB.PingContext(ctx); err != nil {
		return nil, fmt.Errorf("failed to ping database: %w", err)
	}

	return &Client{DB: db}, nil
}

// Close closes the database connection
func (c *Client) Close() error {
	sqlDB, err := c.DB.DB()
	if err != nil {
		return err
	}
	return sqlDB.Close()
}

// HealthCheck verifies the database connection is healthy
func (c *Client) HealthCheck(ctx context.Context) error {
	sqlDB, err := c.DB.DB()
	if err != nil {
		return err
	}
	return sqlDB.PingContext(ctx)
}
