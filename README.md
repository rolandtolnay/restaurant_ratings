# restaurant_ratings

Restaurant Review Mobile App Development in Flutter
(done as part of a job interview)

<div style="display:flex;"> <img src="/ss_home.png" width="240"> <img src="/ss_detail.png" width="240"> <img src="/ss_review.png" width="240"> </div>

# Running the App

`fvm flutter run -d <deviceId>`

# Tech Stack

- Domain: **GetIt**
- State Management: **Riverpod**
- UI: **FlutterHooks**

# Required Feature Descriptions

- **Restaurant Listing:** Users can browse through different restaurants, with data coming from a database or a simple JSON file.
- **Restaurant Details:** Display details of restaurants such as location, menu, ratings.
- **Submit Review:** Allow users to submit ratings and reviews for each restaurant.
- **Search Functionality:** Search for restaurants by name, location or type.

## Technical Requirements

- **Flutter SDK:** Use the latest stable version of Flutter.
- **Data Management:** Load data from a predefined data source, JSON file attached.
- **State Management:** Use a modern state management approach such as Provider, Riverpod, or Bloc.
- **User Interface:** Creative and user-friendly UI that adapts to different screen sizes.

Please spend a maximum of 4 hours on the task solution. The goal is not to have everything done, but to have an appreciable amount of code within the 4 hour timeframe.

## Additional features included

- User reviews are persisted between sessions on the local filesystem
- Loads a random image from the web when opening a restaurant
- Supports switching between English and Hungarian languages
- Contains reusable search component
