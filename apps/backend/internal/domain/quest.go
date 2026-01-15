package domain

import (
	"time"

	"github.com/google/uuid"
)

type QuestStatus string

const (
	QuestStatusActive    QuestStatus = "active"
	QuestStatusCompleted QuestStatus = "completed"
	QuestStatusCancelled QuestStatus = "cancelled"
)

type Quest struct {
	ID          uuid.UUID   `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	UserID      uuid.UUID   `gorm:"type:uuid;index;not null"`
	ShopID      uuid.UUID   `gorm:"type:uuid;index;not null"`
	Status      QuestStatus `gorm:"type:varchar(20);index;not null;default:'active'"`
	CreatedAt   time.Time   `gorm:"not null"`
	UpdatedAt   time.Time   `gorm:"not null"`
	CompletedAt *time.Time  `gorm:"index"`
	User        User        `gorm:"foreignKey:UserID"`
	Shop        Shop        `gorm:"foreignKey:ShopID"`
}
