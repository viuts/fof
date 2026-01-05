package domain

import (
	"time"

	"github.com/google/uuid"
)

type UserFog struct {
	UserID      uuid.UUID `gorm:"type:uuid;primaryKey"`
	ClearedArea *string   `gorm:"type:geometry(MultiPolygon,4326)"`
	UpdatedAt   time.Time
}
