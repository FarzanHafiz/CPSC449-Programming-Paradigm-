
data Piece  = Yellow | Red 

type Column = [Piece]
type Board = [Column]


data BoardState = BS
	{theBoard :: Board,
	lastMove :: Piece,
	numColumns :: Int,
	numRows :: Int,
	numToConnect :: Int}


makeMove :: BoardState -> Int -> Maybe BoardState
makeMove boardState columnPicked = if (checkLegal boardState columnPicked) == True
								   then Just(BS(setBoard (theBoard boardState) columnPicked (switchPiece(lastMove boardState)))(switchPiece(lastMove boardState)) (numColumns boardState) (numRows boardState) (numToConnect boardState))
								   else Nothing


checkLegal:: BoardState -> Int -> Bool
checkLegal boardState columnPicked = if (((numColumns boardState) >= columnPicked  &&  columnPicked > 0)
									 && length((theBoard boardState) !! (columnPicked -1)) < (numRows boardState))
									 then True
									 else False								 


checkWin :: BoardState -> Maybe Piece
checkWin boardState = if (or[checkVertical (theBoard boardState), checkHorizontal (theBoard boardState), checkDiagonal (diagonalsBackward boardState), checkDiagonal (diagonalsForward boardState)]) == True 
					  then undefined
					  else undefined


rows :: BoardState -> [[Maybe Piece]]
rows boardState = undefined


columns :: BoardState -> [[Maybe Piece]]
columns boardState = setPiece (theBoard boardState)(numColumns boardState)(numRows boardState)



diagonalsForward :: BoardState -> [[Maybe Piece]]
diagonalsForward boardState = undefined 


diagonalsBackward :: BoardState -> [[Maybe Piece]]
diagonalsBackward boardState = undefined

setPiece :: Board -> Int -> Int -> [[Maybe Piece]]
setPiece [[piece]] x y = undefined
					


checkVertical :: Board -> Bool
checkVertical boardState =  undefined

checkHorizontal :: Board -> Bool
checkHorizontal boardState =  undefined

checkDiagonal :: [[Maybe Piece]] -> Bool
checkDiagonal boardState = undefined

setBoard :: Board -> Int -> Piece -> Board
setBoard board columnPicked piece= (take (columnPicked - 1) board) ++ [((board !! (columnPicked -1)) ++ [piece])] 
									++ (drop columnPicked board)

switchPiece :: Piece -> Piece
switchPiece Yellow = Red
switchPiece Red = Yellow

