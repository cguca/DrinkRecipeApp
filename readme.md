# Cocktail Recipes App

## Functionality
Thi app allows users to search for cocktail recipes, save  favorite recipes, and create a shopping list. Details descriptions


### Pages
* Home Page
	- The Home Pages displays a random cocktail from the CockailDB API. The user can clicking on the image brings to see the details of the cocktail including ingredients and instructions.
	- Displays drink categories. Clicking on the category name and icon brings the user to a listing page of drinks in that category. Clicking on a drink brings the user to the drink detail page.
      - The list of drink categories are retreived from the CocktailDB API.
* Category Listing Page
        - This page list drinks for the category. To view the details of the drink the user can click on drink.
        - The list of category drinks are retreived from the CocktailDB API.
* Search Page
	- Allows the user to search for drinks by name. Clicking on a drink brings the user to the drink detail page.
* Favorites Page
	- Displays a list of drinks the user saved to their favorites list. 
	- Swiping to the left removes a drink receipe from the favorites list.
        - The favorites are saved to the user's phone using the Core Data frameowork.
* Shopping List Page
	- Displays a list of ingregients the users added to the shopping list.
	- Swiping to the left removed the ingredient from the list.
        - The shopping list is saved to the user's phone using the Core Data frameowork.
* Drink Detail Page
	- Displays the drink recipe, including steps to make the receipe and list of ingredients.
	- Allows the user to save the recipe to their favorites by clicking the heart icon in the top right. The icon is active if the drink recipe is in the favorites list already.
	- Allows the customer to add ingredients to the shopping list by clicking on the ingredient. If the ingredient is already included in the shopping list then the cart icon is active.

## How to build
The app is straight forward to build. It is does not use any third party frameworks or dependancies. Downloading the code from the repository The code can be downloaded and compiled using Xcode.

## Requirements
* Xcode 14.3
* Swift 5

## License
GNU General Public License version 3.

## Known bugs..
* The connection to the Cocktail DB API is erratic the first time the simulator starts.  In case of a connection timeout error, stop and restart the simulator. The connection should stabilize.
* Bad data. Some cocktail recipes ingredients are missing measurements.

