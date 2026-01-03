package domain

import (
	"time"

	"github.com/google/uuid"
	"github.com/lib/pq"
	"gorm.io/gorm"
)

type User struct {
	ID        uuid.UUID `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	Username  string    `gorm:"uniqueIndex;not null"`
	Email     string    `gorm:"uniqueIndex;not null"`
	Level     int       `gorm:"default:1"`
	Exp       int       `gorm:"default:0"`
	CreatedAt time.Time
	UpdatedAt time.Time
	DeletedAt gorm.DeletedAt `gorm:"index"`
}

type Shop struct {
	ID           uuid.UUID `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	Name         string    `gorm:"not null"`
	Category     string
	Lat          float64 `gorm:"not null"`
	Lng          float64 `gorm:"not null"`
	IsChain      bool    `gorm:"default:false"`
	SourceID     string  `gorm:"index"`
	Geom         *string `gorm:"type:geometry(Point,4326)"` // PostGIS Point
	Address      string
	Phone        string
	OpeningHours string
	ImageURLs    pq.StringArray `gorm:"type:text[];column:image_urls"`
	Rating       float64
	SourceURL    string `gorm:"uniqueIndex;column:source_url"`
	CreatedAt    time.Time
	UpdatedAt    time.Time
}

type Visit struct {
	ID        uuid.UUID `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	UserID    uuid.UUID `gorm:"type:uuid;index;not null"`
	ShopID    uuid.UUID `gorm:"type:uuid;index;not null"`
	VisitedAt time.Time `gorm:"not null"`
	Rating    int
	Comment   string
	Exp       int
	User      User `gorm:"foreignKey:UserID"`
	Shop      Shop `gorm:"foreignKey:ShopID"`
}

type UserFog struct {
	UserID      uuid.UUID `gorm:"type:uuid;primaryKey"`
	ClearedArea *string   `gorm:"type:geometry(MultiPolygon,4326)"`
	UpdatedAt   time.Time
}
