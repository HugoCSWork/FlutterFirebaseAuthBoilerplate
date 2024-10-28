# Flutter Firebase Auth Boilerplate 
A base project for implementing complete authentication with Firebase.


## Project Structure 

This project uses a feature-based architecture, where each feature is encapsulated within its own folder, keeping all related logic in a single place.


## Features

* [X] Login
* [X] Register
* [X] Reset Password
* [X] Logout
* [X] Auto Redirect
* [ ] Update User Password
* [ ] Update User Information  
* [ ] Google Authentication


## Testing

The project is built with 100% test coverage to ensure functionality works as intended. Testing includes unit, widget, and integration tests.

![Coverage](coverage_badge.svg)


### Integration Tests

Integration tests require running the Firebase Emulator locally. For setup, refer to [Firebase Emulator Suite Setup](https://firebase.google.com/docs/emulator-suite/install_and_configure). Ensure both authentication and Cloud Firestore are enabled on the emulator.

> **Note**: For Android API versions higher than 28, you may need to allow the local port for the emulator. See this [Stack Overflow solution](https://stackoverflow.com/questions/62984527/error-connecting-to-local-firebase-functions-emulator-from-flutter-app/62985709#62985709) for help.

## How to Run 

Follow the official [Firebase documentation](https://firebase.google.com/docs/flutter/setup?platform=android) to setup Firebase. Ensure both Authentication and Cloud Firestore are enabled for your selected project.


## Packages

* **Riverpod** - State management
* **Flutter Hooks** - For form state management
* **Firebase Packages** - Handles authentication and cloud storage
* **Form Builder Validator** - Simple form validation
* **Go Router** - Routing and authentication redirection
* **Mockito** - Mock classes for unit and widget testing
