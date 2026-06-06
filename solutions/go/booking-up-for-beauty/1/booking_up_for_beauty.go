package booking

import (
	"fmt"
	"time"
)

// Schedule returns a time.Time from a string containing a date.
func Schedule(date string) time.Time {
	formats := []string{
		"1/2/2006 15:04:05",
		"January 2, 2006 15:04:05",
		"Monday, January 2, 2006 15:04:05",
		"Monday, January 2, 2006 3:04:05 PM",
	}

	var t time.Time
	var err error

	for _, layout := range formats {
		t, err = time.Parse(layout, date)
		if err == nil {
			return t.UTC()
		}
	}

	return time.Time{}
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
	return Schedule(date).Before(time.Now().UTC())
}

// IsAfternoonAppointment returns whether a time is in the afternoon
func IsAfternoonAppointment(date string) bool {
	t := Schedule(date)
	hour := t.Hour()
	return hour >= 12 && hour < 18
}

// Description returns a formatted string of the appointment time
func Description(date string) string {
	t := Schedule(date)
	return fmt.Sprintf("You have an appointment on %s", t.Format("Monday, January 2, 2006, at 15:04."))
}

// AnniversaryDate returns a Time with this year's anniversary
func AnniversaryDate() time.Time {
	currentYear := time.Now().Year()
	anniversary := fmt.Sprintf("%d-09-15 00:00:00", currentYear)
	t, _ := time.Parse("2006-01-02 15:04:05", anniversary)
	return t
}
