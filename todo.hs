module Main where

import Data.IORef
import Haste
import Haste.DOM
import View 
import Model 

main = withElems ["todoapp"] start

renderAllTodos tsRef todoList = do
  ts <- readIORef tsRef
  todoElems <- mapM renderTodo ts
  mapM (bindTodoEvents tsRef todoList) todoElems
  setChildren todoList $ map todoRootEl todoElems

onCancelEditTodo tde = setClass (todoRootEl tde) "editing" False

onSaveEditTodo tsRef todoList tde = do
  Just v <- getValue (todoInputEl tde)
  modifyIORef tsRef (\ts -> editOneTodoText ts (todoId $ todoModel tde) v)
  renderAllTodos tsRef todoList

onEditTodo tsRef todoList tde k pt = do
  setClass (todoRootEl tde) "editing" True
  onEvent (todoInputEl tde) OnKeyUp (\k -> case k of
      13 -> (onSaveEditTodo tsRef todoList tde)
      27 -> (onCancelEditTodo tde)
      otherwise -> return () )
  onEvent (todoInputEl tde) OnBlur (onCancelEditTodo tde)
  return ()

onDestroyTodo tsRef todoList tde k pt = do
  modifyIORef tsRef (\ts -> deleteTodo ts (todoId $ todoModel tde))
  renderAllTodos tsRef todoList

onToggleComplete tsRef todoList tde k pt = do
  modifyIORef tsRef (\ts -> toggleOneComplete ts (todoId $ todoModel tde))
  renderAllTodos tsRef todoList

bindTodoEvents tsRef todoList tde = do
  onEvent (todoLabelEl tde)   OnDblClick (onEditTodo tsRef todoList tde)
  onEvent (todoToggleEl tde)  OnClick    (onToggleComplete tsRef todoList tde)
  onEvent (todoDestroyEl tde) OnClick    (onDestroyTodo tsRef todoList tde)

onTodoKeyUp tsRef input todoList k = case k of
  13 -> do
    Just v <- getValue input
    if v == "" then
      return ()
    else do
      modifyIORef tsRef (\ts -> addTodo ts v)
      ts <- readIORef tsRef
      todoElems <- mapM renderTodo ts
      mapM (bindTodoEvents tsRef todoList) todoElems
      setChildren todoList $ map todoRootEl todoElems
      setProp input "value" ""
  _  -> return ()

start [parentEl] = do
  tsRef <- newIORef $ []
  container <- renderContainer []
  setChildren parentEl (allEl container)
  onEvent (newTodoEl container) OnKeyUp (onTodoKeyUp tsRef (newTodoEl container) (todoListEl container))
