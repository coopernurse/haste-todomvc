module View where

import Model
import Haste.DOM

data TodoElem = TodoElem {
	todoModel      :: Todo,
	todoRootEl     :: Elem, 
	todoToggleEl   :: Elem, 
	todoDestroyEl  :: Elem,
	todoLabelEl    :: Elem,
	todoInputEl    :: Elem
}

renderTodo :: Todo -> IO TodoElem
renderTodo t = do
	root    <- newElem "li"
	viewDiv <- newElem "div"
	input   <- newElem "input"
	setClass input "edit" True
	setProp input "value" (todoText t)
	toggle <- newElem "input"
	setClass toggle "toggle" True
	setProp toggle "type" "checkbox"
	label <- newElem "label"
	setProp label "innerHTML" (todoText t)
	destroy <- newElem "button"
	setClass destroy "destroy" True
	setClass viewDiv "view" True
	if (todoComplete t) then do
		setProp toggle "checked" "checked" 
		setClass root "completed" True
	else return ()
	setChildren viewDiv [toggle, label, destroy]
	setChildren root    [viewDiv, input]
	return TodoElem{todoModel=t, todoRootEl=root, todoToggleEl=toggle, 
		todoDestroyEl=destroy, todoLabelEl=label, todoInputEl=input}

renderActiveCount :: [Todo] -> String
renderActiveCount [] = ""
renderActiveCount ts = (show len) ++ " " ++ (pluralize ("item", "items") len) ++ " left"
  where len = length ts

renderCompletedCount :: [Todo] -> String
renderCompletedCount [] = ""
renderCompletedCount ts = "Clear completed (" ++ (show $ length ts) ++ ")"

