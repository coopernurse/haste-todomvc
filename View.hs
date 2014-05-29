module View where

import Model
import Haste.DOM

data TodoContainerElem = TodoContainerElem {
	allEl         :: [Elem],
	newTodoEl     :: Elem,
	toggleAllEl   :: Elem,
	todoListEl    :: Elem
}

data TodoElem = TodoElem {
	todoModel      :: Todo,
	todoRootEl     :: Elem, 
	todoToggleEl   :: Elem, 
	todoDestroyEl  :: Elem,
	todoLabelEl    :: Elem,
	todoInputEl    :: Elem
}

renderContainer :: [Todo] -> IO TodoContainerElem
renderContainer ts = do
	header <- newElem "header"
	setAttr header "id" "header"
	headerTitle <- newElem "h1"
	headerTitleText <- newTextElem "todos"
	setChildren headerTitle [headerTitleText]
	input  <- newElem "input"
	setAttr input "id" "new-todo"
	setAttr input "placeholder" "What needs to be done?"
	setAttr input "autofocus" "autofocus"
	setChildren header [headerTitle, input]
	section <- newElem "section"
	setAttr section "id" "main"
	toggleCheckbox <- newElem "input"
	setAttr toggleCheckbox "id" "toggle-all"
	setAttr toggleCheckbox "type" "checkbox"
	toggleLabel <- newElem "label"
	toggleLabelText <- newTextElem "Mark all as complete"
	setChildren toggleLabel [toggleLabelText]
	setAttr toggleLabel "for" "toggle-all"
	todoList <- newElem "ul"
	setAttr todoList "id" "todo-list"
	setChildren section [toggleCheckbox, toggleLabel, todoList]
	footer <- newElem "footer"
	setAttr footer "id" "footer"
	return TodoContainerElem{allEl=[header,section,footer], newTodoEl=input, 
		toggleAllEl=toggleCheckbox, todoListEl=todoList}

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

