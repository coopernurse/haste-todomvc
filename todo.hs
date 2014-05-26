module Main where

import Haste
import Haste.Reactive
import Control.Applicative
--import qualified Control.Concurrent as C
import Data.IORef
import Data.List

main = withElems ["new-todo", "todo-list", "toggle-all"] start

renderTodoListSingle :: String -> String
renderTodoListSingle xs = "hello " ++ xs

renderTodoList :: [String] -> String
renderTodoList xs = "hello " ++ (intercalate ", " xs)
--renderTodoList xs = intercalate "" $ (map (\s -> "a"++s) xs)
--                  "<li>" ++
--                  " <div class='view'>" ++
--                  "   <input class='toggle' type='checkbox' />" ++
--                  "   <label>" ++ s ++ "</label>" ++
--                  "   <button class='destroy'></button>" ++
--                  " </div>" ++
--                  " <input class='edit' value='three' />" ++
--                  "</li>" )

start [newTodo, todoList, toggleAll] = do
  xs <- newIORef []
  --elemProp "todo-list.innerHTML" << renderTodoList <$> append xs <*> "op" `valueAt` OnKeyUp
  --elemProp "todo-list.innerHTML" << (pure renderTodoList) <*> (\x -> append xs x) <$> "new-todo" `valueAt` OnKeyUp
  elemProp "todo-list.innerHTML" << (pure renderTodoListSingle) <*> "new-todo" `valueAt` OnKeyUp

append :: IORef [String] -> String -> IO [String] 
append xs s = do
  cur <- readIORef xs
  writeIORef xs $ cur++[s]
  readIORef xs

--addTodo todos newTD = do
--  cur <- C.takeMVar todos
--  C.putMVar todos $ cur++[newTD]
--  cur' <- C.readMVar todos
--  writeLog $ "NewTD: " ++ (intercalate ", " cur')

--start [newTodo, todoList, toggleAll] = do
--  todos <- C.newMVar []
--  onEvent newTodo OnKeyUp $ \k -> do   -- TODO: clean this up. how do we filter events?
--    case k of
--      13 -> do
--        newTD <- getProp newTodo "value"
--        addTodo todos newTD
--        setProp newTodo "value" ""
--      _ -> return ()
--    

