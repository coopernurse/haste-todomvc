module Main where

import Data.IORef
import Haste
import Haste.DOM
import View 
import Model 

main = withElems ["new-todo", "todo-list", "toggle-all"] start

onTodoKeyUp input todoList tsRef k = case k of
  13 -> do
    Just v <- getValue input
    if v == "" then
      return ()
    else do
      modifyIORef tsRef (\ts -> addTodo ts v)
      ts <- readIORef tsRef
      setProp todoList "innerHTML" $ renderTodos $ ts
      setProp input "value" ""
  _  -> return ()

start [todoInput, todoList, toggleAll] = do
  tsRef <- newIORef $ []
  onEvent todoInput OnKeyUp (onTodoKeyUp todoInput todoList tsRef)
