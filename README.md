# Unit 3 Mid-Unit Assessment

## Git Setup

1. Fork this repository
2. Clone **your fork** locally to your laptop.
3. Work on the assignment.
4. Upon completion, commit locally.

	```
	git add -A
	git commit -m "<NAME> final submission"
	```
5. Push to your repo.

	```
	git push origin master
	```
6. Go to github and make a pull request.
7. Paste the link from **your fork** into canvas 


# Overview

You are given two json files in the project folder. Create an app with a Tab Bar Controller and two tabs.  The first tab is single screen representing [Jeopardy](https://en.wikipedia.org/wiki/Jeopardy!) (A trivia game).  The second tab is list of books by the author Terry Pratchett.  Selecting a book should segue to a Detail View Controller with more information.

# Part One: Jeopardy

**JSON Source:**

- [Jeopardy API](http://jservice.io/api/random?count=100)

Notes:

- The *value* key might be absent or match to nil.


**Requirements:**

The first tab is comprised of a single View Controller which should have:

- An image with the Jeopardy logo included in your Assets.xcassets folder.
- A text label to represent the *Category*
- A text label to represent the *Value* (How many points the question was worth on the show)
- A text field where the user can input their answer
- A text label representing the message the user will recieve after guessing a word
- A button to go to the next question

**Details**

When the view loads, a question should already by loaded for the user to view.  When the user presses return after inputing a guess to the text field, a message should display.  

The message should tell the user whether or not they guessed correctly and display the correct answer if they guessed wrong. 

You should be comparing the user's guess against the correct answer **case insensitively**.  Don't worry about the user getting it wrong because of a slight difference between their answer and the correct answer.  For example, it's fine if the user gets it wrong when entering "foray" when the correct answer is "a foray".


**Extra Credit opportunities:**

- Add a score tracker.  Guessing wrong should subtract that many points from your score.
- Add better handling for matching the user's input to the correct answer.


# Part Two: Books

**JSON Source:**

[Google Books API](https://www.googleapis.com/books/v1/volumes?q=Pratchett)

**Notes**

- The *subtitle* is sometimes absent.  Be sure to still make a book even if it doesn't have a subtitle.

**Requirements:**

The View Controller of your Tab Bar Controller should be  a Navigation Controller.  The root of your Navigation Controller should be a View Controller with a table view inside.  Selecting a row in your table view should segue to a View Controller with additional details.

**Table View**

- It's fine to user a default table view cell
- The *textLabel* of each cell should be the book's title
- The *detailTextLabel* of each cell should be the book's price

**Detail View Controller**

Your Detail View Controller should include:

- An image containining the default book image
- A text label with the book's name
- A text label with the book's subtitle (if available)
- A text label with the book's price
- A text label with the book's author
- A text view with the book's summary

**Extra Credit opportunities:**

- Add a text label with the ISBN_13 code to your detail view controller
- Load the actual book thumbnail instead of using the default image


# Rubric

Criteria | Points
:---|:---
App uses AutoLayout correctly for all iPhones in portrait | 8 Points
Follows MVC design | 4 Points
Variable Naming and Readability | 4 Points
| Jeopardy JSON is parsed appropriately | 4 points
| Jeopardy questions are loaded into the View Controller | 4 points
| Jeopardy game logic works as expected | 4 points
| Book JSON is parsed appropriately | 4 points
| Books are loaded into the table view | 4 points
| Book Detail View Controller works as expected | 4 points

A total of 40 points, with 4 extra credit.



