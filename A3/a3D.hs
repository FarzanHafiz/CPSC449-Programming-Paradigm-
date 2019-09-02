
module GameLogic where 
import Data.List
data Piece = Red | Yellow 
type Column = [Piece]
type Board = [Column]

data BoardState = BS 
  {
      theBoard :: Board,
      lastMove :: Piece,
      numColumns :: Int,
      numRows :: Int,
      numToConnect :: Int
  }

makeMove :: BoardState -> Int -> Maybe BoardState
makeMove bs colPicked = Just(BS ((take (colPicked - 1) (theBoard bs)++ [(((theBoard bs) !! (colPicked -1))++ [lastMove bs])]++ (drop colPicked (theBoard bs))))
							(lastMove bs) (numColumns bs) (numRows bs) (numToConnect bs))
								
								
legalCheck :: BoardState -> Int -> Bool
legalCheck bs c = if 0 < c && c < (numRows bs) then True 
				 else False
	
	

changeColor :: Piece -> Piece 
changeColor Red = Yellow 
changeColor Yellow = Red
checkWin :: BoardState -> Maybe Piece
checkWin bs = if (or[checkRow (theBoard bs), checkColumn  (theBoard bs), diagonalCheck ( diagonalsBackward bs), diagonalCheck (map (\rows -> padN rows (numColumns bs)) (map (map Just)(transpose (diagonalsForward bs))))]) == True 
					  then undefined
					  else undefined

rows :: BoardState -> [[Maybe Piece]]
rows bs = map (\rows -> padN rows (numColumns bs)) (map (map Just)(transpose (theBoard bs)))

columns :: BoardState -> [[Maybe Piece]]
columns bs = map (\col -> padN col (numRows bs)) (map (map Just)(theBoard bs))

padN :: [Maybe Piece] -> Int -> [Maybe Piece]
padN xs n =   xs ++  replicate ( n - (length xs )) Nothing 

checkRow :: Board -> Bool 
checkRow = undefined

checkColumn :: Board -> Bool
checkColumn = undefined
 
diagonalCheck :: [[Maybe Piece]] -> Bool 
diagonalCheck b = undefined 


diagonalsForward :: BoardState -> [[Piece]]
diagonalsForward bs =
	if(numColumns bs) < (numRows bs) 
	then [[((theBoard bs) !! y) !! x | x <- [0..((numColumns bs) -1)], 
                            y <- [0..((numColumns bs) - 1)], 
                            x + y == numToConnect] 
		| numToConnect <- [0..((numColumns bs)-1) + ((numRows bs)-1)]]
	if(numColumns bs >= (numRows bs))
    then [[((theBoard bs) !! y) !! x | x <- [0..((numColumns bs) - 1)], 
                            y <- [0..((numColumns bs) - 1)], 
                            x + y == numToConnect] 
		| numToConnect <- [0.. (numColumns bs) + (numRows bs)]]
		    
diagonalsBackward :: BoardState -> [[Maybe Piece]]
diagonalsBackward = undefined
