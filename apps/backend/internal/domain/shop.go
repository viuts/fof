package domain

import (
	"time"

	"github.com/google/uuid"
	"github.com/lib/pq"
)

type BusinessDay string

const (
	BusinessDayMonday    BusinessDay = "mon"
	BusinessDayTuesday   BusinessDay = "tue"
	BusinessDayWednesday BusinessDay = "wed"
	BusinessDayThursday  BusinessDay = "thu"
	BusinessDayFriday    BusinessDay = "fri"
	BusinessDaySaturday  BusinessDay = "sat"
	BusinessDaySunday    BusinessDay = "sun"
	BusinessDayHoliday   BusinessDay = "hol"
)

type TimeInterval struct {
	Open  string `json:"open"`
	Close string `json:"close"`
}

type BusinessHours map[BusinessDay][]TimeInterval

type Shop struct {
	ID              uuid.UUID `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	Name            string    `gorm:"not null"`
	Category        string
	Lat             float64 `gorm:"not null"`
	Lng             float64 `gorm:"not null"`
	IsChain         bool    `gorm:"default:false"`
	Geom            *string `gorm:"type:geometry(Point,4326)"` // PostGIS Point
	Address         string
	Phone           string
	OpeningHours    BusinessHours  `gorm:"type:jsonb"`
	ImageURLs       pq.StringArray `gorm:"type:text[];column:image_urls"`
	Rating          float64
	SourceURL       string  `gorm:"uniqueIndex;column:source_url"`
	ClearanceRadius float64 `gorm:"column:clearance_radius"`
	Reservable      bool    `gorm:"default:false"`
	CreatedAt       time.Time
	UpdatedAt       time.Time
}
