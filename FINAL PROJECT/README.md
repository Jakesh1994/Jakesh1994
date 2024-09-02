# MY TODO APP
## Video Demo:  (https://www.youtube.com/watch?v=l_bJnmuXkfc)
### Description: A fully functional EXAMPLE project Todo app for those who forget what they have and have not done yet.

This project is an example that was built along with a YouTube video showing the application working. this project uses the fundamental features of JavaScript, CSS and html. some of the features are listed below.

* JSON.stringify that converts a JavaScript object or value to a JSON string. (used to convert Todo's to JSON for saving when the screen is refreshed)
* SVG, or Scalable Vector Graphics, is an XML-based markup language for describing two-dimensional vector graphics.
* Root used for declaring global CSS variables. (in this document used for background color as well as colors of objects)
* Event listener allows you to respond to specific user interactions, such as clicks or key press (used in this document delete and submit).
* Prevent method in JavaScript is used to prevent the default action of an event from occurring.

This project started off as an index.html where I used a form input field to show the "write anything" function and hit enter to add field why turning off autocomplete.
with an id field of Todo- input used later.
I used a hard coded Todo list to adjust the style of the worksheet.
Using an unordered list to start making the Todo list i made sure the list had a id of todo-1.
At first, I used a checkbox to make my Todo list work but later found out that I needed a custom checkbox for my style sheet to look the way I wanted it to work.

Moving onto styles
I used CSS variables in my root to define my color palette used. Once that was created, I moved onto all the elements starting off with a margin and padding of 0.
the html element was simple once I found a font I was happy with I pasted the code in html then I continued to list more elements to style with a live server pulled
up to see the changes in real time. Using the pseudo-class hover I changed the website to change when the user interacts with different elements adjusting the transition
to not look unnatural to the eye. In the checkbox element I used a checked pseudo-class to adjust a few styles when the checkbox is checked giving a more satisfying transition.
I ended up adjusting the elements when viewed on different devices so that it continues to look natural to the user on any style of device

JavaScript
With JavaScript I tested many times to make sure it continued to work by using a simple event listener for submit however after submitting the page did reload automatically and I did not want this to happen.
Using a e. prevent default prevents the page from reloading.
 using many functions, I made the website interactive starting off with the add Todo. Thinking about user ease i used the trim function to prevent unwanted spaces.
 Upon testing found users can submit blank Todo's so to prevent used the if function and put that the Todo needs to be greater than 0 in length.
 once a Todo is added that fits those criteria it is added to a table. Changing the Todo to a Todo item made it possible to add to the list.
 Making a new function of update Todo list made the Todo list update automatically once submitted was successful. in the Todo update function created the Todo item Todo index as well as Todo.
 With the create Todo item used the Todo List to update to Todo. using inner html to make the Todo's look good.

storing data used the function save Todo's with a function of local storage set item. The function requires i set the Todo as a string using the function JSON.stringify this was possible.
once the local storage was taken care of, I used the function log to keep track of all my Todo's.
Found that when the page was loaded it did not keep the checkbox. To fix that I used the function of an event listener showing check box check = completed and saved in the local storage marking as completed true and false.



Fonts used by this project are from the free open source
https://fonts.google.com/icons?selected=Material+Symbols+Outlined:delete:FILL@0;wght@400;GRAD@0;opsz@24&icon.query=trash&icon.size=24&icon.color=%23000000