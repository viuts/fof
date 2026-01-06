.PHONY: gen backend mobile db help

# Default target
all: help

## gen: Generate code from Protobuf definitions using buf
gen:
	buf generate

## db: Start the PostGIS database using Docker Compose
db:
	docker-compose up -d

## db-stop: Stop the PostGIS database
db-stop:
	docker-compose down

## db-logs: View database logs
db-logs:
	docker-compose logs -f

## backend: Run the Go backend service
backend:
	@cd apps/backend && go run cmd/server/main.go

## mobile: Run the Flutter mobile application
mobile-local:
	@cd apps/mobile && flutter run --dart-define=ENV=local

mobile-dev:
	@cd apps/mobile && flutter run --dart-define=ENV=dev

mobile-web:
	@cd apps/mobile && flutter run -d chrome --web-port 65282

mobile-web-dev:
	@cd apps/mobile && flutter run -d chrome --web-port 65282 --dart-define=ENV=dev

## gen-db: Generate GORM Gen code
gen-db:
	@cd apps/backend && go run cmd/gen/main.go

gen-intl:
	@cd apps/mobile && flutter gen-l10n

migrate-up:
	@cd apps/backend && go run cmd/migrate/main.go up

migrate-down:
	@cd apps/backend && go run cmd/migrate/main.go down

crawl-tabelog:
	@cd apps/backend && go run cmd/tabelog-crawler/main.go

## help: Show this help message
help:
	@echo "Fog of Flavor Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make <target>"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'
