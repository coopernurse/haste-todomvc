module Main where

import Haste

main = withElems ["new-todo", "todo-list", "toggle-all"] start

start [newTodo, todoList, toggleAll] = do
	setProp newTodo "innerHTML" "something"
