{-	Name: Shah Farzan Al-Hafiz
	ID: 10162590				-}
	
--	This is teh design component for assignment 3 of CPSC 449. 

data Piece = Yellow | Red

type Column = [Piece]
type Board = [Column]

data BoardState = BS
	{theBoard :: Board,
	lastMove :: Piece,
	numColumns :: Int,
	numRows:: Int,
	numToConnect :: Int}

--	makeMove function takes in BoardState and an Int as input and returns the updated BoardState
makeMove :: BoardState -> Int -> Maybe BoardState
makeMove = 

checkWin :: BoardState -> Maybe Piece
checkWin = undefined

columns :: BoardState -> [[Maybe Piece]]
columns = undefined

rows :: BoardState -> [[Maybe Piece]]
rows = undefined

diagonalsForward :: BoardState -> [[Maybe Piece]]
diagonalsForward = undefined

diagonalsBackward :: BoardState -> [[Maybe Piece]]
diagonalsBackward = undefined
