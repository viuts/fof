package domain

import (
	"database/sql/driver"
	"encoding/json"
	"errors"
	"strconv"
	"strings"
	"time"

	"github.com/google/uuid"
	"github.com/lib/pq"
)

// Helper to check opening hours
func (b BusinessHours) IsOpen(t time.Time) bool {
	// 0=Sun, 1=Mon...
	days := []BusinessDay{
		BusinessDaySunday,
		BusinessDayMonday,
		BusinessDayTuesday,
		BusinessDayWednesday,
		BusinessDayThursday,
		BusinessDayFriday,
		BusinessDaySaturday,
	}

	checkTime := func(day BusinessDay, h int, isPreviousDay bool) bool {
		intervals, ok := b[day]
		if !ok {
			return false
		}
		for _, interval := range intervals {
			openH, _ := strconv.Atoi(strings.Split(interval.Open, ":")[0])
			closeH, _ := strconv.Atoi(strings.Split(interval.Close, ":")[0])

			if closeH < openH {
				// Crosses midnight (e.g. 18:00 - 02:00)
				if isPreviousDay {
					// We are the "next day", so we check if hour < closeH
					if h < closeH {
						return true
					}
				} else {
					// Same day, check if hour >= openH
					if h >= openH {
						return true
					}
				}
			} else if !isPreviousDay {
				// Normal range, only check if not looking at previous day
				if h >= openH && h < closeH {
					return true
				}
			}
		}
		return false
	}

	dayIndex := int(t.Weekday())
	hour := t.Hour()

	// Check today
	if checkTime(days[dayIndex], hour, false) {
		return true
	}

	// Check yesterday (for late night hours ending today)
	prevDayIndex := (dayIndex - 1 + 7) % 7
	return checkTime(days[prevDayIndex], hour, true)
}

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
	ClearanceRadius float64 `gorm:"column:clearance_radius;->"` // Read-only (Generated)
	Reservable      bool    `gorm:"default:false"`
	CreatedAt       time.Time
	UpdatedAt       time.Time
}

// Scan implements the Scanner interface.
func (b *BusinessHours) Scan(value interface{}) error {
	if value == nil {
		*b = nil
		return nil
	}
	bytes, ok := value.([]byte)
	if !ok {
		return errors.New("type assertion to []byte failed")
	}
	return json.Unmarshal(bytes, b)
}

// Value implements the driver Valuer interface.
func (b BusinessHours) Value() (driver.Value, error) {
	return json.Marshal(b)
}
