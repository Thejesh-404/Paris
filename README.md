# Paris

Paris is a native iOS app that allows users to browse and explore dessert recipes using TheMealDB API. 
Users can view a list of dessert meals,and select any meal to see detailed information including instructions and ingredients. 

## Features

- Browse a list of dessert recipes from TheMealDB API.
- View detailed information about each recipe, including instructions and ingredients.

## Endpoints

The app utilizes the following API endpoints:

- `https://themealdb.com/api/json/v1/1/filter.php?c=Dessert` for fetching the list of meals in the Dessert category.
- `https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID` for fetching the meal details by its ID.


## Requirements

- Xcode 17.5
- iOS 15.0 +
- Swift 5.0+

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/YourUsername/Paris.git
    ```
2. Open the project in Xcode

3. Build and run the app on your simulator or device.
