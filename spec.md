Here is the `Spec.md` for **Fog of Flavor**, translated and refined for an English-speaking development environment.

---

# Spec.md: Fog of Flavor (FoF)

## 1. Project Overview
- **Concept**: Visualize your "Gastronomic Journey." Clear the map fog by exploring the real world, specifically rewarding visits to independent restaurants with little online presence.
- **Target Audience**: Solo food explorers, indie restaurant hunters, and "map completionist" gamers.
- **Core Value**: Providing the thrill of discovery in the age of information overload by rewarding users for finding "hidden gems" rather than just following high-rated spots.

## 2. Tech Stack
- **Monorepo**: Managed via `turbo` or `go workspaces`.
- **Frontend**: Flutter (Mobile)
- **Backend**: Golang 1.25+
- **Cloud**: Google Cloud Platform (GCP)
- **Database**: PostgreSQL 17+ with **PostGIS** extension (required for spatial queries).
- **ORM**: GORM
- **Communication**: REST API (Defined via Protobuf/gRPC-Gateway)
- **Data Source**: Tabelog API (Initial), Google Places API (Future integration).

## 3. System Architecture
### 3.1. Backend (Golang)
- **Architecture**: Clean Architecture (Domain, Usecase, Repository, Handler).
- **API Definition**: Defined in `api/proto/v1/*.proto`, generating Go structs and JSON mappings.
- **Spatial Processing**: Leveraging PostGIS to calculate "Fog Clearing" areas based on user coordinates and restaurant polygons.

### 3.2. Frontend (Flutter)
- **Map Engine**: `flutter_map` (OpenStreetMap-based for flexibility) or `google_maps_flutter`.
- **Fog Rendering**: Custom Painter or Canvas API using a tile-based overlay system.
- **Location Strategy**: Battery-efficient tracking using the `geolocator` package.
    - **Policy**: Minimize active GPS. Use `DistanceFilter` (e.g., 20m) and "Significant Change Location" service. Stay detection is triggered by accelerometer data + dwell time at a single coordinate.

## 4. Database Schema (Entities)
### `users`
- `id`, `username`, `email`, `created_at`

### `shops` (Initial data: Tabelog)
- `id`, `name`, `category`, `lat`, `lng`, `is_chain` (bool), `source_id`, `geom` (PostGIS Geometry)

### `visits` (Visit History)
- `id`, `user_id`, `shop_id`, `visited_at`
- *Note: These records turn a shop into a "Beacon" (Highlight) on the map.*

### `fog_tiles` (Cleared Areas)
- `user_id`, `tile_id` (H3 Index or custom Grid ID)
- *Note: To optimize performance, clearing is stored as Grid IDs rather than raw GPS tracks.*

## 5. API Definition (Protobuf)

```proto
syntax = "proto3";
package fof.v1;

import "google/api/annotations.proto";

service FlavorService {
  // Clear fog on the map (Send current location)
  rpc UpdateLocation(UpdateLocationRequest) returns (UpdateLocationResponse) {
    option (google.api.http) = {
      post: "/v1/location"
      body: "*"
    };
  }

  // Get nearby unvisited indie shops (For Quest/Explore mode)
  rpc GetNearbyShops(GetNearbyShopsRequest) returns (GetNearbyShopsResponse) {
    option (google.api.http) = {
      get: "/v1/shops/nearby"
    };
  }

  // Get list of visited shops for highlighting
  rpc GetVisitedShops(GetVisitedShopsRequest) returns (GetVisitedShopsResponse) {
    option (google.api.http) = {
      get: "/v1/shops/visited"
    };
  }
}

message UpdateLocationRequest {
  double lat = 1;
  double lng = 2;
  double accuracy = 3;
}

message UpdateLocationResponse {
  bool newly_cleared = 1; // True if new area was unlocked
  repeated string cleared_tile_ids = 2; 
}

message GetNearbyShopsRequest {
  double lat = 1;
  double lng = 2;
  double radius_meters = 3;
  bool exclusive_independent = 4; // Filter for indie shops only
}

message GetNearbyShopsResponse {
  repeated Shop shops = 1;
}

message Shop {
  string id = 1;
  string name = 2;
  double lat = 3;
  double lng = 4;
  string category = 5;
  bool is_visited = 6;
}
```

## 6. Core Logic
### 6.1. Fog Clearing Mechanics
- **Standard Movement**: As the user moves, GPS coordinates are sent via `UpdateLocation`. The backend marks the corresponding Grid IDs as "cleared."
- **Dining Discovery**: 
    1. System detects the user has stayed within 50m of a `shop` coordinate for >20 mins.
    2. A `Visit` record is generated.
    3. The map clears a **Large Radius (e.g., 200m)** around the restaurant instantly.

### 6.2. Independent vs. Chain Logic
- Filter shops from Tabelog/Google. If a shop name appears >N times nationally or matches a known chain list, it is flagged as `is_chain: true`.
- Chain stores provide minimal fog clearing; Independent stores provide maximum clearing and "Exp" (Experience Points).

## 7. GCP Infrastructure
- **Cloud Run**: Hosting the Go Backend (Auto-scaling).
- **Cloud SQL for PostgreSQL**: Managed DB with PostGIS enabled.
- **Artifact Registry**: Docker image management for CI/CD.
- **Secret Manager**: Storing API keys and DB credentials.

## 8. Development Roadmap (Milestones)
1. **Phase 1 (MVP)**:
    - Basic "Fog of World" movement tracking.
    - Render map with "Fog of War" overlay.
2. **Phase 2 (Flavor Integration)**:
    - Import shop data and implement "Stay Detection" logic.
    - Implement "Visit Beacons" (Highlighting visited shops).
3. **Phase 3 (Quest & Polish)**:
    - Add "Quest Mode" (Compass-based navigation to unvisited indie shops).
    - Gamified leveling system based on "Tasted Categories."

---

### Developer Notes
- **Spatial Optimization**: Use `ST_DWithin` in PostGIS for high-performance proximity checks.
- **Battery Efficiency**: Implement "Geofencing" on the mobile side. Wake the app's location logic only when entering a designated restaurant zone to preserve battery life.