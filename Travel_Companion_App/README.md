
Architecture: What did I use, and why?

The app is built with CLEAN Architecture and MVVM, split into feature-first folders.
    •    Presentation, Domain, and Data layers are clearly separated, with protocols for testability and scalability.
    •    Networking is abstracted into its own module (NetworkKit), ready for injection as a Swift Package or xcframework. I am just showcasing the use of SPM here.
    •    Each feature (like Places, YouTube (hypothetical- not added yet) is fully modular, so new functionality can be plugged in or swapped out with zero hassle.
    •    This structure keeps business logic out of the UI, makes everything more testable, and ensures the project can grow—whether you add new APIs, new presentation layers (e.g., Watch, Mac), or scale up a team.

Benefits:
    •    Easier to test and debug. I have also covered few very important test files for ViewModel and repository.
    •    No hardcoding of dependencies.
    •    Future enhancements (AI, new APIs, etc.) can be slotted in without rewiring the app
    •    Cleaner onboarding for new developers. Its more like a skeleton.


What can be enhanced next?
    •    Add powerful filters for distance, type, or sort order; even show the POIs on a map.
    •    Route mapping and itinerary planning could be taken to the next level with AI—e.g., suggest an optimal route for a family day out, or build an itinerary with ChatGPT.
    •    I’ve also dropped in a placeholder YouTube feature to demonstrate how easily new features can be modularized and integrated. (Honestly, I’m one of those users who gets excited about places after watching YouTube shorts or reviews!) 
    •    Other enhancements I’d tackle in production: login/auth, polish UI and UX, string localization, accessibility support, and security hardening.
    •    All hardcoded strings are flagged and can be migrated to a constants/localization layer for clean, scalable maintenance.
    •    Async/await is used for networking, but Combine would be great for pipelines where more data transformation is required.



A Few Quick Notes:
    •    A Google Cloud API key is required to run the app. Because it’s tied to billing, I haven’t included it in the repo—but I’m happy to share it privately if you’d like to test it.
    •    Location handling and permissions are set up and tested.
    •    The app currently fetches places within 10km, but this is tunable if needed.
    •    The intention is not to show off UI/UX—this is a demo of clean architecture, structure, and code quality for iOS teams.
