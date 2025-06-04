# Venue Listing App
A simple iOS app that displays a list of venues, allows users to mark/unmark favourites, and automatically refreshes the data every 10 seconds. Built with modern iOS development practices such as MVVM, Dependency Injection, and SOLID principles.


# Minimum Deployment Target
iOS 15+, Only iPhone Portrait mode is supported


# Technologies Used
Swift 5.0+, Xcode 16+
UIKit
MVVM architecture
Dependency Injection (DI)
SOLID principles
JSON Parsing
Error Handling
Unit Testing with XCTest


# Features
Launch Screen: Displays an initial loading screen before showing venue data.
Venue Listing: Lists venues fetched from a remote API.
Favourite Button: Users can mark/unmark venues as their favourite, with data persistence via UserDefaults.
Dark Mode Support: The app adapts to both light and dark modes, ensuring a consistent and comfortable user experience in various lighting conditions.
Automatic Refresh: Venue data is automatically refreshed every 10 seconds.
Error Handling: Handles network failures, parsing issues, and corrupted data.
Centralized Constants: All app constants, such as API URLs, keys, and UI strings, are stored in a dedicated Constants.swift file, promoting cleaner code and easier maintenance.
Unit Testing: Includes mock tests for JSON parsing, network manager, view model, and storage manager.
Accessibilty Testing: Significant accessibility label and hints are provided to suppport Voice Over support
UI Testing: Includes UI testing for the list screen to load and swipe up



# Architecture
The app follows the MVVM (Model-View-ViewModel) architecture to separate concerns and improve testability.



# Key Components:
Model: Represents the data structure of a venue.
View: Displays the user interface and reacts to ViewModel updates.
ViewModel: Handles business logic, data fetching, and view updates.
Network Manager: Manages network requests and responses.
Storage Manager: Handles local persistence (using UserDefaults for now).
Constants: A dedicated file (Constants.swift) that stores all app-wide constants.



# Features Breakdown

1. Venue Listing 
Displays a list of venues fetched from a remote API.
Each venue has a favourite button to toggle its favourite status.
2. Automatic Data Refresh 
Venue data is refreshed every 10 seconds.
3. Persistence of Favourite Status 
User's favourite venue status is saved in UserDefaults and persists across app restarts.
4. Dark Mode Support 
The app adapts to both light and dark modes, providing a consistent and comfortable user experience.
5. Centralized Constants 
All app constants are stored in a dedicated Constants.swift file, promoting cleaner code and easier maintenance.
6. JSON Parsing 
A custom JSON parser using Swift's Codable protocol decodes venue data, ensuring type safety and simplifying the parsing process.
7. Error Handling 
Network errors, data parsing errors, and other issues are handled gracefully.
User-friendly error messages are shown when issues occur.


# Unit Tests
The app includes tests for the following components:

Mock JSON Parsing: Tests that JSON data is parsed correctly into model objects.
Mock Network Manager: Simulates network requests and responses for testing.
ViewModel: Ensures that the view model correctly updates the UI with fetched data.
Storage Manager: Verifies the correct saving and loading of favourite venue status in UserDefaults.

# Running Tests
To run tests, open the project in Xcode and go to the Test navigator. Click the Run button to execute all tests.



# Future Improvements
CoreData/Realm Integration: Replace UserDefaults with a more robust persistence solution.
CoreLocation: Replace the location array with user's real time location
Offline Support: Cache venue data and display it when the user is offline.
Swift Concurrency (async/await): Refactor async code to use Swift's concurrency model for cleaner code.
SwiftUI
Mulitple Device orientations
