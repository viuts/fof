package domain

import (
	"time"

	"github.com/google/uuid"
	"github.com/lib/pq"
)

type Visit struct {
	ID        uuid.UUID      `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	UserID    uuid.UUID      `gorm:"type:uuid;index;not null"`
	ShopID    uuid.UUID      `gorm:"type:uuid;index;not null"`
	VisitedAt time.Time      `gorm:"not null"`
	Rating    int
	Comment   string
	ImageURLs pq.StringArray `gorm:"type:text[];column:image_urls"`
	Exp       int
	User      User `gorm:"foreignKey:UserID"`
	Shop      Shop `gorm:"foreignKey:ShopID"`
}
