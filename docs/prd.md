# Product Requirements Document: Fog of Flavor (FoF)

**Version:** 1.0  
**Status:** Draft  
**Owner:** Product Team  
**Date:** January 3, 2026  

---

## 1. Executive Summary
**Fog of Flavor (FoF)** is a gamified, location-based discovery app that rewards users for exploring the physical world through food. Unlike traditional restaurant apps that rely on star ratings and reviews, FoF uses a "Fog of War" mechanic—inspired by *Fog of World*—where the map is covered in darkness until the user physically visits a location. The product specifically prioritizes the discovery of **independent, non-chain restaurants** to restore the thrill of "accidental" discovery.

---

## 2. Goals & Objectives
*   **Primary Goal:** Create a habit-forming "passive" exploration experience where users track their life's culinary footprint.
*   **User Value:** Provide a sense of achievement (map completion) and curated discovery of "hidden gems" without information overload.
*   **Business Objective:** Build a proprietary dataset of foot traffic and "indie" restaurant locations that are underrepresented on major platforms (Google/Yelp).

---

## 3. Target Audience
1.  **The Solo Foodie:** People who enjoy dining alone and seeking out "authentic" local experiences.
2.  **The Completionist:** Gamers and data-enthusiasts who love tracking stats and "clearing" maps.
3.  **The Urban Explorer:** Users who have become bored with their neighborhood and need an incentive to turn a different corner.

---

## 4. Functional Requirements

### 4.1. Core Map & Fog System
*   **FR-1: Fog Overlay:** The entire world map must be covered in a dark "Fog" layer by default.
*   **FR-2: Path Clearing:** As the user moves (GPS), the fog clears in a narrow path (approx. 5-10m radius).
*   **FR-3: Dining Blast:** When a user dines at a restaurant, the fog clears in a much larger radius (e.g., 200m) around that shop.
*   **FR-4: Map Persistence:** Cleared areas must be saved server-side and rendered instantly upon app launch.

### 4.2. Restaurant Database & "Indie" Logic
*   **FR-5: Shop Beacons:** Once a shop is visited, its icon remains permanently highlighted on the map as a "Beacon."
*   **FR-6: Cuisine Coloring:** Beacons should be color-coded by category (e.g., Ramen = Red, Cafe = Green, Pub = Blue).
*   **FR-7: Chain Detection:** The system must distinguish between chains and independent shops.
    *   *Logic:* If a shop name exists in >5 locations or matches a known brand list, it is marked as a "Chain."
    *   *Impact:* Chains provide 90% less "Fog Clearing" radius and fewer XP points.

### 4.3. Stay Detection (Passive Check-in)
*   **FR-8: Dwell Time Logic:** To clear a "Dining Blast," the user must stay within the shop's geofence for at least 20 minutes.
*   **FR-9: Battery Optimization:** The app should use low-power location monitoring (Cell tower/Wi-Fi) and only spin up high-accuracy GPS when movement is detected or a potential "Stay" is occurring.

### 4.4. Quest Mode (RNG Discovery)
*   **FR-10: Genre Quest:** User selects a category (e.g., "Sushi").
*   **FR-11: Fog-Guided Navigation:** The app selects a nearby, **unvisited, independent** shop hidden in the fog. 
*   **FR-12: The Compass:** The app provides a compass needle and distance but **hides the shop name and reviews** until the user arrives.

---

## 5. Non-Functional Requirements

### 5.1. Performance & Scalability
*   **Latency:** Map tile loading and fog state retrieval must happen in <200ms.
*   **Concurrency:** Backend (Golang) must support 10k+ concurrent location updates via optimized REST/Protobuf endpoints.

### 5.2. Battery & Power
*   **Efficiency:** The app must not consume more than 5% of total daily battery life in background mode.

### 5.3. Privacy
*   **Data Security:** Location history must be encrypted. Users must have the option to "Freeze Tracking" or delete specific path history.

---

## 6. User Experience (UI/UX)
*   **Theme:** Dark mode by default (to emphasize the "Fog" and "Light" contrast).
*   **Map Style:** Minimalist vector maps.
*   **Visual Feedback:** "Fog clearing" should have a smooth, satisfying animation (particle effects or soft gradients).
*   **Sound:** Low-foley, satisfying "ping" when a new shop is discovered or a quest is completed.

---

## 7. Technical Overview (Summary)
*   **Platform:** Flutter (iOS/Android).
*   **Backend:** Go (GCP Cloud Run) + PostgreSQL (PostGIS).
*   **Map Tile System:** H3 Hexagonal Hierarchical Spatial Index (for efficient fog storage).
*   **Data Sync:** Protobuf for lightweight background data transmission.

---

## 8. Success Metrics (KPIs)
*   **Retention (D30):** % of users who continue clearing fog after 30 days.
*   **Exploration Rate:** Average square kilometers cleared per user per week.
*   **Indie Discovery:** Number of "low-information" shops visited vs. total visits.
*   **Quest Completion:** % of triggered Quests that result in a successful dining event.

---

## 9. Roadmap
*   **V1.0 (MVP):** Basic fog clearing, Tabelog data import, visit highlighting.
*   **V1.1:** Social features (compare cleared area % with friends).
*   **V1.2:** AI-driven "Taste Profile" based on cleared shop categories.
*   **V1.3:** Integration with AR glasses (visualizing fog in the real world).