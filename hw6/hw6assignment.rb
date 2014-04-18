# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyTetris < Tetris
  # your enhancements here
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_180_degrees})
    @root.bind('c', proc {@board.cheat})
  end
end

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here

  # your enhancements here
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  def self.cheat(board)
    MyPiece.new(Cheat_Piece,board)
  end

  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
                rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
                [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
                 [[0, 0], [0, -1], [0, 1], [0, 2]]],
                rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
                rotations( [[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
                rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
                rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
                rotations([[0, 0], [-1, 0], [1, 0], [0, -1],[-1,-1]]),
                [[[0, 0], [-1, 0], [1, 0], [2, 0],[-2,0]],
                 [[0, 0], [0, -1], [0, 1], [0, 2],[0,-2]]] ,
                rotations([[0, 0], [0, -1], [1,0]])]
  Cheat_Piece = [[[0,0]]]
end

class MyBoard < Board
  # your enhancements here
  def rotate_180_degrees
    rotate_clockwise
    rotate_clockwise
  end

  def next_piece
    if @is_cheat
      @current_block = MyPiece.cheat(self)
      @is_cheat = false
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0...locations.size).each do |index|
      current = locations[index]
      @grid[current[1] + displacement[1]][current[0] + displacement[0]] =
          @current_pos[index]
    end
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  def cheat
    @cheat_cost = 100
    return if @score < @cheat_cost or @is_cheat
    @is_cheat = true
    @score -= @cheat_cost
  end
end
