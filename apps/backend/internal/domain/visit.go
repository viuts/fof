package domain

import (
	"time"

	"github.com/google/uuid"
)

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
