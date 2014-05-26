
# TodoMVC Design

## Events

* add new todo
  * when enter key pressed, take the value of the input box, add it to the list, and repaint the list
    * the lower left "x item(s) left" count should increment

* delete todo
  * when 'x' clicked on a row, remove that row from the list and repaint the list on screen

* toggle todo complete
  * when checkbox clicked on a row, toggle the 'complete' state on the todo
    * if complete: strikeout the todo text and make checkmark green
    * if not complete: display todo text normally and make checkmark gray
    * in both cases, propegate the event:
      * the lower right "Clear completed" count should update
      * the lower left "x item(s) left" count should update

* mark all completed
  * when down arrow thingy (to left of new todo input) is clicked, mark all todos complete

* clear completed
  * when clicked all 'complete' rows should be removed and the list repainted
    * "Clear completed" box should disappear

* status filter - all / active / completed
  * default: all
  * when modified, filter todo list by state
     * deleted todos are never shown
     * "cleared" todos are never shown
  * filter doesn't change the "x item(s) left" box
  * filter doesn't change the "clear completed" box
