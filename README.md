# AltCoinTrader

## Mobile App
### Description
Built a Mobile app in Flutter to showcase what I am able to provide
### How to run
Can be started using `flutter run` in terminal
### Architecture
- Flutter for easy cross-platform development.
- Flutter Bloc Pattern for state management and splits ui and logic components for easy data management and clean code.
- Created a custom Route Manager which enables better validations/redirects/deep-links than standard flutter navigation.
- Used dependency injection to initialize Cubits and enables all cubits and states to be easily accessed from anywhere using sl.-prefix
- Created a Master State Extension to reduce code duplication and enables better handling of messages, errors, and actions. 
- All Themes and colors are built and overrides the default Flutter `Theme.of(context)` method which enables all styles and colors to be consistent and easily changeable as well as supports multiple theme modes like light/dark
- Used a ScreenController Cubit to take advantage of the UI rebuilds it provides to make transitions between main pages instant
### Future Improvements
- Add the rest of the altcoin trader functionality

## Web App
### Description
Decided on a game style theme as that is one of my hobbies.
### How to run
Can be started using `npm run start` in terminal
### Architecture
- Next.js App Router for clean url structure.
- Implemented static classes to make it easy to import and use.
- useGames to manage functionality on /games page.
### Future Improvements
- Add Unit Tests
- Implement verification to enable only authorized personnel to edit data.
- Add lookup data for publishers/developers/categories.
- Allow you to add and manage more categories than just the pre-set categories as well as being able to add multiple genres to a title.
- Add filters for categories/developers/publisher similar to hwo you can filter by status
- Implement Pagination to improve api requests and prevent infinite scrolling if you have 1000+ titles.
