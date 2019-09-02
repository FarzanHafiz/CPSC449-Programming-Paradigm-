{- Name: Shah Farzan Al-Hafiz 
	ID: 10162590		
	
	This is the implementation component for assignment 3 of CPSC 449.
-}
		

data Piece = Red | Yellow deriving Show
type Column = [Piece]
type Board = [Column]

data BoardState = BS 
  {
      theBoard :: Board,
      lastMove :: Piece,
      numColumns :: Int,
      numRows :: Int,
      numToConnect :: Int
  } deriving Show

makeMove :: BoardState -> Int -> Maybe BoardState
makeMove bs colPicked = if (checkLegal bs colPicked) == True  
						then Just(BS ((take (colPicked - 1) (theBoard bs)++ [(((theBoard bs) !! (colPicked -1))++ [colourSwitch(lastMove bs)])]++ (drop colPicked (theBoard bs))))
							(colourSwitch(lastMove bs)) (numColumns bs) (numRows bs) (numToConnect bs))
						else Nothing

checkWin :: BoardState -> Maybe Piece
checkWin bs = undefined

checkLegal :: BoardState -> Int -> Bool
checkLegal bs c = if 0 < c && c < (numRows bs) then True 
				 else False
	
colourSwitch :: Piece -> Piece 
colourSwitch Red = Yellow 
colourSwitch Yellow = Red

--transposeMatrix function transposes the given matrix. Reference: StackOverflow.
transposeMatrix :: [[a]]->[[a]]
transposeMatrix ([]:_) = []
transposeMatrix x = (map head x) : transposeMatrix (map tail x)

padN :: [Maybe Piece] -> Int -> [Maybe Piece]
padN xs n =   xs ++  replicate ( n - (length xs )) Nothing 

rows :: BoardState -> [[Maybe Piece]]
rows bs = map (\rows -> padN rows (numColumns bs)) (map (map Just)(transposeMatrix (theBoard bs)))

columns :: BoardState -> [[Maybe Piece]]
columns bs = map (\col -> padN col (numRows bs)) (map (map Just)(theBoard bs))

diagonalsForward :: BoardState -> [[Maybe Piece]]
diagonalsForward bs = (diagonalLowerHalf (map (reverse)(columns (bs))) [] 0 0 (numColumns bs)(numRows bs)) ++ (diagonalUpperHalf (map (reverse)(columns (bs))) [] 1 ((numRows bs) -1) (numColumns bs)(numRows bs))

diagonalsBackward :: BoardState -> [[Maybe Piece]]
diagonalsBackward bs = (diagonalLowerHalf (columns (bs)) [] 0 0 (numColumns bs)(numRows bs)) ++ (diagonalUpperHalf (columns (bs)) [] 1 ((numRows bs) -1) (numColumns bs)(numRows bs))

diagonalUpperHalf :: [[Maybe Piece]] -> [[Maybe Piece]] -> Int -> Int -> Int -> Int -> [[Maybe Piece]]
diagonalUpperHalf currentBoard diagonal x y col row = if (x >= col)
													then diagonal
													else diagonalUpperHalf currentBoard (diagonal ++ [(getDiagonalUpperHalf currentBoard [] x y col)]) (x+1) (row - 1) col row

getDiagonalUpperHalf :: [[Maybe Piece]] -> [Maybe Piece] -> Int -> Int -> Int -> [Maybe Piece]
getDiagonalUpperHalf currentBoard diagonal x y col = if(x >= col)
													then diagonal
													else getDiagonalUpperHalf currentBoard (diagonal ++ [((currentBoard !! x) !!y)]) (x + 1) (y-1) col

diagonalLowerHalf :: [[Maybe Piece]] -> [[Maybe Piece]] -> Int -> Int -> Int -> Int -> [[Maybe Piece]]
diagonalLowerHalf currentBoard diagonal x y col row = if (y >= (row))
													then diagonal
													else diagonalLowerHalf currentBoard (diagonal ++ [(getDiagonalLowerHalf currentBoard [] x y col)]) 0 (y+1) col row

getDiagonalLowerHalf :: [[Maybe Piece]] -> [Maybe Piece] -> Int -> Int -> Int -> [Maybe Piece]
getDiagonalLowerHalf currentBoard diagonal x y col = if(y < 0 || x >= col)
													then diagonal
													else getDiagonalLowerHalf currentBoard (diagonal ++ [((currentBoard !! x) !!y)]) (x + 1) (y-1) col
