# Cocktail Recipes App

## Functionality
The app allows you to search for cocktail recipes, save your favorite recipes, and save a shopping list.

### Pages
* Home Page
	- Displays a random cocktail. Clicking on the image brings the user to the drink detail page.
	- Displays drink categories. Clicking on the category name and icon brings the user to a listing page of drinks in that category. Clicking on a drink brings the user to the drink detail page.
* Search Page
	- Allows the user to search for drinks by name. Clicking on a drink brings the user to the drink detail page.
* Favorites Page
	- Displays a list of drinks the user saved to their favorites list.
	- Swiping to the left removes a drink receipe from the favorites list.
* Shopping List Page
	- Displays a list of ingregients the users added to the shopping list.
	- Swiping to the left removed the ingredient from the list.
* Drink Detail Page
	- Displays the drink recipe, including steps to make the receipe and list of ingredients.
	- Allows the user to save the recipe to their favorites by clicking the heart icon in the top right. The icon is active if the drink recipe is in the favorites list already.
	- Allows the customer to add ingredients to the shopping list by clicking on the ingredient. If the ingredient is already included in the shopping list then the cart icon is active.



## Known bugs.
The connection to the Cocktail DB API is erratic the first time the simulator starts.  In case of a connection timeout error, stop and restart the simulator. The connection should stabilize.
