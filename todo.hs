module Main where

import Haste
import Haste.DOM
import View 
import Model 

main = withElems ["new-todo", "todo-list", "toggle-all"] start

onTodoKeyUp input todoList k = case k of
  13 -> do
    Just v <- getValue input
    setProp todoList "innerHTML" $ renderTodos $ addTodo [] v
    setProp input "value" ""
  _  -> return ()

start [todoInput, todoList, toggleAll] = do
  onEvent todoInput OnKeyUp (onTodoKeyUp todoInput todoList)
