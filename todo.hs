module Main where

import Haste
import qualified Control.Concurrent as C
import Data.List

main = withElems ["new-todo", "todo-list", "toggle-all"] start

addTodo todos newTD = do
	cur <- C.takeMVar todos
	C.putMVar todos $ cur++[newTD]
	cur' <- C.readMVar todos
	writeLog $ "NewTD: " ++ (intercalate ", " cur')

start [newTodo, todoList, toggleAll] = do
	todos <- C.newMVar []
	onEvent newTodo OnKeyUp $ \k -> do   -- TODO: clean this up. how do we filter events?
		case k of
			13 -> do
				newTD <- getProp newTodo "value"
				addTodo todos newTD
				setProp newTodo "value" ""
			_ -> return ()
		