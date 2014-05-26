module View where

import Model
import Data.List 

renderTodos :: [Todo] -> String
renderTodos ts = intercalate "" $ map renderTodo ts

renderTodo :: Todo -> String
renderTodo t = "<li>" ++
                  " <div class='view'>" ++
                  "   <input class='toggle' type='checkbox' />" ++
                  "   <label>" ++ (todoText t) ++ "</label>" ++
                  "   <button class='destroy'></button>" ++
                  " </div>" ++
                  " <input class='edit' value='" ++ (show $ todoId t) ++ "' />" ++
                  "</li>"

renderActiveCount :: [Todo] -> String
renderActiveCount [] = ""
renderActiveCount ts = (show len) ++ " " ++ (pluralize ("item", "items") len) ++ " left"
  where len = length ts

renderCompletedCount :: [Todo] -> String
renderCompletedCount [] = ""
renderCompletedCount ts = "Clear completed (" ++ (show $ length ts) ++ ")"

