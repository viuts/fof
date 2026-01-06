package repository

import (
	"context"
	"fmt"
	"strings"
	"time"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/gorm"
)

type UserRepository interface {
	GetOrCreateUser(ctx context.Context, firebaseUID, email string) (*domain.User, error)
	GetByID(ctx context.Context, userID uuid.UUID) (*domain.User, error)
	Save(ctx context.Context, user *domain.User) error
	SaveWithTx(ctx context.Context, tx *gorm.DB, user *domain.User) error
}

type userRepository struct {
	db *gorm.DB
}

func NewUserRepository(db *gorm.DB) UserRepository {
	return &userRepository{db: db}
}

func (r *userRepository) GetOrCreateUser(ctx context.Context, firebaseUID, email string) (*domain.User, error) {
	var user domain.User
	username := ""
	if parts := strings.Split(email, "@"); len(parts) > 0 {
		username = parts[0]
	}
	if username == "" {
		username = "user"
	}
	username = fmt.Sprintf("%s_%s", username, uuid.New().String()[:8])

	err := r.db.WithContext(ctx).Where(domain.User{FirebaseUID: firebaseUID}).Attrs(domain.User{
		Email:        email,
		Username:     username,
		DisplayName:  "", // Will be updated by middleware sync
		ProfileImage: "", // Will be updated by middleware sync
		Level:        1,
		Exp:          0,
		CreatedAt:    time.Now(),
		UpdatedAt:    time.Now(),
	}).FirstOrCreate(&user).Error

	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *userRepository) GetByID(ctx context.Context, userID uuid.UUID) (*domain.User, error) {
	var user domain.User
	if err := r.db.WithContext(ctx).First(&user, "id = ?", userID).Error; err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *userRepository) Save(ctx context.Context, user *domain.User) error {
	return r.db.WithContext(ctx).Save(user).Error
}

func (r *userRepository) SaveWithTx(ctx context.Context, tx *gorm.DB, user *domain.User) error {
	return tx.WithContext(ctx).Save(user).Error
}
