module Model where

data TodoFilter = All | Active | Completed

data Todo = Todo {todoId::Int, todoComplete::Bool, todoText::String} deriving (Eq,Show)

filterTodos :: [Todo] -> TodoFilter -> [Todo]
filterTodos ts All       = ts
filterTodos ts Active    = filter (not . todoComplete) ts
filterTodos ts Completed = filter todoComplete ts

setTodoComplete :: Todo -> Bool -> Todo
setTodoComplete t b = t { todoComplete = b }

setTodoText :: Todo -> String -> Todo
setTodoText t s = t { todoText = s }

nextId :: [Todo] -> Int
nextId [] = 1
nextId ts = (maximum $ map todoId ts) + 1

addTodo :: [Todo] -> String -> [Todo]
addTodo ts text = ts ++ [Todo{todoId=(nextId ts), todoComplete=False, todoText=text}]

deleteTodo :: [Todo] -> Int -> [Todo]
deleteTodo ts id = filter (\x -> (todoId x) /= id) ts

toggleComplete :: Todo -> Todo
toggleComplete t = setTodoComplete t $ not $ todoComplete t

toggleOneComplete :: [Todo] -> Int -> [Todo]
toggleOneComplete ts id = map (\x -> if (todoId x) == id then (toggleComplete x) else x) ts

setAllComplete :: [Todo] -> [Todo]
setAllComplete ts = map (\t -> setTodoComplete t True) ts

editOneTodoText :: [Todo] -> Int -> String -> [Todo]
editOneTodoText ts id s = map (\t -> if (todoId t) == id then (setTodoText t s) else t) ts

completedCount :: [Todo] -> Int 
completedCount ts = length $ filter todoComplete ts

activeCount :: [Todo] -> Int
activeCount ts = (length ts) - (completedCount ts)

pluralize :: (String, String) -> Int -> String
pluralize pair c = if c == 1 then (fst pair) else (snd pair)
