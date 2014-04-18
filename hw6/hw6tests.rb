require 'rspec'
require_relative 'hw6provided'
require_relative 'hw6assignment'

## Stub out graphics wrapper ##
class TetrisRoot
  attr_accessor :bindings

  # track bindings for test
  def bind(char, callback)
    @bindings ||= {}
    @bindings[char] = callback
  end
end

class TetrisTimer ; def stop ; end ; def start(d, c) ; end ;end
class TetrisCanvas ; def place(h, w, x, y) ; end ; def unplace ; end ; def delete ; end ;end
class TetrisLabel ; def place(h, w, x, y) ; end ; def text(str) ; "foo" ; end ; end
class TetrisButton ; def place(height, width, x, y) ; end ;end
class TetrisRect ; def remove ; end ; def move(dx, dy) ; end ; end
## end of graphics stub

# tests
describe "Homework 6" do
  describe MyTetris do

    before(:each) do
      @game = MyTetris.new
      @board = @game.instance_variable_get(:@board)
    end

    it "should be an instance of Tetris" do
      @game.should be_a_kind_of Tetris
    end

    it "should use my board" do
      @board.should be_a MyBoard
    end

    it "should bind 14 keys including u and c" do
      @game.instance_variable_get(:@root).bindings.should have(14).items
      @game.instance_variable_get(:@root).bindings.should have_key('u')
      subject.instance_variable_get(:@root).bindings.should have_key('c')
    end

    it "c key should not change score with score < 100" do
      cheat_proc = @game.instance_variable_get(:@root).bindings['c']
      @board.instance_variable_set(:@score, 99)
      cheat_proc.call
      @board.score.should == 99
    end

    it "c key should reduce score 100 with score >= 100" do
      cheat_proc = @game.instance_variable_get(:@root).bindings['c']
      @board.instance_variable_set(:@score, 100)
      cheat_proc.call
      @board.score.should == 0
    end

    it "c key should reduce score 100 only once while a piece is falling" do
      cheat_proc = @game.instance_variable_get(:@root).bindings['c']
      @board.instance_variable_set(:@score, 400)
      cheat_proc.call
      cheat_proc.call
      cheat_proc.call
      @board.score.should == 300
    end

    it "c key should make the next piece be the cheat piece" do
      cheat_proc = @game.instance_variable_get(:@root).bindings['c']
      @board.instance_variable_set(:@score, 400)
      cheat_proc.call
      @board.next_piece
      @board.instance_variable_get(:@current_block).
          instance_variable_get(:@all_rotations).should eq [[[0, 0]]]
    end
  end

  describe MyBoard do
    before(:each) do
      @board = MyBoard.new(MyTetris.new)
    end

    it "should be a subclass of Board" do
      @board.should be_a_kind_of Board
    end

    it "should use MyPiece" do
      @board.instance_variable_get(:@current_block).should be_a MyPiece
    end
  end

  describe MyPiece do
    before(:each) do
      @tetris = MyTetris.new
      @board = MyBoard.new @tetris
    end

    it "should be a subclass of Piece" do
      @piece = MyPiece.new(MyPiece::All_My_Pieces[0], @board)
      @piece.should be_a_kind_of Piece
    end

    it "should have 10 pieces in All_My_Pieces" do
      MyPiece::All_My_Pieces.should have(10).items
    end

    it "should have the original 7 in All_My_Pieces" do
      (MyPiece::All_My_Pieces & Piece::All_Pieces).should == Piece::All_Pieces
    end

    it "All_My_Pieces should be a [[[]]]" do
      MyPiece::All_My_Pieces.each do |el1|
        el1.each do |el2|
          el2.should be_an Array
        end
      end
    end

    it "should have one new piece with 3 points" do
      count = 0
      (MyPiece::All_My_Pieces - Piece::All_Pieces).each do |piece|
        if piece[0].length == 3
          count += 1
          piece.each {|e| e.should have(3).items}
        end
      end
      count.should == 1
    end

    it "should have two new pieces with 5 points" do
      count = 0
      (MyPiece::All_My_Pieces - Piece::All_Pieces).each do |piece|
        if piece[0].length == 5
          count += 1
          piece.each {|e| e.should have(5).items}
        end
      end
      count.should == 2
    end

  end
end