# Event Management App

## Overview
The **Event Management App** is a SwiftUI-based application designed to allow users to explore, filter, and manage events efficiently. The app integrates features such as event category selection, date filtering, interactive maps, and detailed event views. Its intuitive interface ensures a smooth user experience while enabling easy navigation and interaction with event data.

Key features include:  
- Browse and search for events by category or date.  
- **Discover Screen:** Provides a searchable, filterable list of events with dynamic categories and segmented filters.  
- **Event Map Screen:** Visualize events on an interactive map with annotations and swipeable cards to highlight selected events.  
- View detailed event information with a dedicated Event Details screen.  
- Responsive UI optimized for iOS devices using SwiftUI.  
- Asynchronous data fetching for seamless user experience and smooth scrolling.

---

## Running the App Locally

To run the app on your local machine, follow these steps:

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/EventManagementApp.git

   Screens & Features
* Discover Screen

- Search bar with real-time filtering.

- Category menu for filtering events dynamically.

- Segmented picker for additional filtering options (e.g., price, date).

- Infinite scrolling to load more events as users scroll.

- Color-coded category tags for better visual distinction.

* Event Map Screen

- Displays all events on an interactive map using MapKit.

- Dynamic annotations for each event location.

- Swipeable event cards to quickly navigate between events.

- Tap annotation to highlight the corresponding event card.

- Supports interactive map gestures (zoom, pan).

* Event Details Screen

- Displays detailed information for each selected event.

- Includes ticket price, date, and event description.

- Navigation integration from both Discover and Map screens.



# Advanced Features & Optimizations

- Optimized Async Data Loading

- Event data is loaded asynchronously using Combine and async/await for smooth UI performance.

- Dynamic Filtering

- Real-time search, category filtering, and segmented filters for fast results.

- State Management

- @Published and @MainActor ensure reactive UI updates.

- Consistent handling of API states: loading, ui, error.

- Map Integration

- Interactive map with annotations and swipeable cards.

- Dynamic region based on selected event.

- Reusability & Modularity

- Custom SwiftUI components (BodyText, DescriptionText, EventCardView) improve reusability.

- Error Handling

Graceful network error handling with retry options and fallback UI.
