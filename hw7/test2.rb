require "./hw7.rb"

class Intersect
  attr_reader :e1, :e2
end

class Var
  attr_reader :s
end

class Let
  attr_reader :s, :e1, :e2
end

class Shift
  attr_reader :dx, :dy, :e
end

class Point < GeometryValue
  def ==(p)
    self.class == p.class and @x == p.x and @y == p.y
  end
end

class Line < GeometryValue
  def ==(l)
    self.class == l.class and @m == l.m and @b == l.b
  end
end

class VerticalLine < GeometryValue
  def ==(vl)
    self.class == vl.class and @x == vl.x
  end
end

class LineSegment < GeometryValue
  def ==(ls)
    self.class == ls.class and @x1 == ls.x1 and @y1 == ls.y1 and @x2 == ls.x2 and @y2 == ls.y2
  end
end

class Intersect < GeometryExpression
  def ==(i)
    self.class == i.class and @e1 == i.e1 and @e2 == i.e2
  end
end

class Let < GeometryExpression
  def ==(l)
    self.class == l.class and @s == l.s and @e1 == l.e1 and @e2 == l.e2
  end
end

class Var < GeometryExpression
  def ==(v)
    self.class == v.class and @s == v.s
  end
end

class Shift < GeometryExpression
  def ==(s)
    self.class == s.class and @dx == s.dx and @dy == s.dy and @e == s.e
  end
end

if not (Let.new("a", LineSegment.new(3.2,4.1,3.2,4.1), LineSegment.new(3.2,4.1,3.2,4.1)).preprocess_prog == Let.new("a", Point.new(3.2, 4.1), Point.new(3.2, 4.1)))
  puts "Let preprocess_prog test fails"
end

if not (Shift.new(1.0, 2.0, LineSegment.new(3.2,4.1,3.2,4.1)).preprocess_prog == Shift.new(1.0, 2.0, Point.new(3.2, 4.1)))
  puts "Shift preprocess_prog test fails"
end

if not (Intersect.new(LineSegment.new(3.2,4.1,3.2,4.1), LineSegment.new(3.2,4.1,3.2,4.1)).preprocess_prog == Intersect.new(Point.new(3.2, 4.1), Point.new(3.2, 4.1)))
  puts "Intersect preprocess_prog test fails"
end

if not (Shift.new(3.0, 4.0, Point.new(4.0, 4.0)).eval_prog([]) == Point.new(7.0, 8.0))
  puts "Shift eval_prog test fails with Point"
end

if not (Shift.new(3.0, 4.0, Line.new(4.0, 4.0)).eval_prog([]) == Line.new(4.0, -4.0))
  puts "Shift eval_prog test fails with Line"
end

if not (Shift.new(3.0, 4.0, VerticalLine.new(4.0)).eval_prog([]) == VerticalLine.new(7.0))
  puts "Shift eval_prog test fails with VerticalLine"
end

if not (Shift.new(3.0, 4.0, LineSegment.new(4.0, 3.0, 12.0, -2.0)).eval_prog([]) == LineSegment.new(7.0, 7.0, 15.0, 2.0))
  puts "Shift eval_prog test fails with LineSegment"
end

if not (Intersect.new(Point.new(4.0, 4.0), Point.new(4.0, 4.0)).eval_prog([]) == Point.new(4.0, 4.0))
  puts "Intersect test #1 fails for Point/Point"
end
if not (Intersect.new(Point.new(4.0, 4.0), Point.new(4.0, 4.1)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #2 fails for Point/Point"
end
if not (Intersect.new(Point.new(4.0, 4.0), Line.new(4.0, 4.1)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #1 fails for Point/Line"
end
if not (Intersect.new(Point.new(1.0, 8.0), Line.new(4.0, 4.0)).eval_prog([]) == Point.new(1.0, 8.0))
  puts "Intersect test #2 fails for Point/Line"
end
if not (Intersect.new(Point.new(5.0, 4.0), VerticalLine.new(4.0)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #1 fails for Point/VerticalLine"
end
if not (Intersect.new(Point.new(4.0, 4.0), VerticalLine.new(4.0)).eval_prog([]) == Point.new(4.0, 4.0))
  puts "Intersect test #2 fails for Point/VerticalLine"
end
if not (Intersect.new(Point.new(2.0, 2.0), LineSegment.new(1.0, 1.0, 4.0, 4.0)).eval_prog([]) == Point.new(2.0, 2.0))
  puts "Intersect test #1 fails for Point/LineSegment"
end
if not (Intersect.new(Point.new(4.1, 4.1), LineSegment.new(1.0, 1.0, 4.0, 4.0)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #2 fails for Point/LineSegment"
end

if not (Intersect.new(Line.new(4.0, 4.0), Point.new(1.0, 8.0)).eval_prog([]) == Point.new(1.0, 8.0))
  puts "Intersect test #1 fails for Line/Point"
end
if not (Intersect.new(Line.new(4.0, 4.0), Point.new(4.0, 4.1)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #2 fails for Line/Point"
end
if not (Intersect.new(Line.new(4.0, 4.0), Line.new(4.0, 4.1)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #1 fails for Line/Line"
end
if not (Intersect.new(Line.new(1.0, 7.0), Line.new(4.0, 4.0)).eval_prog([]) == Point.new(1.0, 8.0))
  puts "Intersect test #2 fails for Line/Line"
end
if not (Intersect.new(Line.new(4.0, 4.0), VerticalLine.new(4.0)).eval_prog([]) == Point.new(4.0, 20.0))
  puts "Intersect test fails for Line/VerticalLine"
end
if not (Intersect.new(Line.new(-1.0, 1.0), LineSegment.new(1.0, 1.0, 4.0, 4.0)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #1 fails for Line/LineSegment"
end
if not (Intersect.new(Line.new(-1.0, 2.0), LineSegment.new(1.0, 1.0, 4.0, 4.0)).eval_prog([]) == Point.new(1.0, 1.0))
  puts "Intersect test #2 fails for Line/LineSegment"
end

if not (Intersect.new(VerticalLine.new(4.0), Point.new(4.0, 8.0)).eval_prog([]) == Point.new(4.0, 8.0))
  puts "Intersect test #1 fails for VerticalLine/Point"
end
if not (Intersect.new(VerticalLine.new(4.0), Point.new(4.1, 4.0)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #2 fails for VerticalLine/Point"
end
if not (Intersect.new(VerticalLine.new(4.0), Line.new(4.0, 4.0)).eval_prog([]) == Point.new(4.0, 20.0))
  puts "Intersect test fails for VerticalLine/Line"
end
if not (Intersect.new(VerticalLine.new(4.0), VerticalLine.new(4.1)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #1 fails for VerticalLine/VerticalLine"
end
if not (Intersect.new(VerticalLine.new(4.0), VerticalLine.new(4.0)).eval_prog([]) == VerticalLine.new(4.0))
  puts "Intersect test #2 fails for VerticalLine/VerticalLine"
end
if not (Intersect.new(VerticalLine.new(4.1), LineSegment.new(1.0, 1.0, 4.0, 4.0)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #1 fails for VerticalLine/LineSegment"
end
if not (Intersect.new(VerticalLine.new(2.0), LineSegment.new(1.0, 1.0, 4.0, 4.0)).eval_prog([]) == Point.new(2.0, 2.0))
  puts "Intersect test #2 fails for VerticalLine/LineSegment"
end

# Intersection tests with LineSegment and Point/Line/VerticalLine
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), Point.new(2.0, 2.0)).eval_prog([]) == Point.new(2.0, 2.0))
  puts "Intersect test #1 fails for LineSegment/Point"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), Point.new(4.1, 4.1)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #2 fails for LineSegment/Point"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), Line.new(-1.0, 1.0)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #1 fails for LineSegment/Line"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), Line.new(-1.0, 2.0)).eval_prog([]) == Point.new(1.0, 1.0))
  puts "Intersect test #2 fails for LineSegment/Line"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), VerticalLine.new(4.1)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #1 fails for LineSegment/VerticalLine"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), VerticalLine.new(2.0)).eval_prog([]) == Point.new(2.0, 2.0))
  puts "Intersect test #2 fails for LineSegment/VerticalLine"
end

# Intersection between a vertical LineSegment and Point/Line/VerticalLine
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), Point.new(1.0, 2.0)).eval_prog([]) == Point.new(1.0, 2.0))
  puts "Intersect test #3 fails for LineSegment/Point"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), Point.new(1.0, 4.1)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #4 fails for LineSegment/Point"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), Line.new(-1.0, 1.0)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #3 fails for LineSegment/Line"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), Line.new(-1.0, 4.0)).eval_prog([]) == Point.new(1.0, 3.0))
  puts "Intersect test #4 fails for LineSegment/Line"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), VerticalLine.new(4.1)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #3 fails for LineSegment/VerticalLine"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), VerticalLine.new(1.0)).eval_prog([]) == LineSegment.new(1.0, 1.0, 1.0, 4.0))
  puts "Intersect test #4 fails for LineSegment/VerticalLine"
end

# intersection between two oblique LineSegments
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), LineSegment.new(4.1, 4.1, 5.0, 5.0)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #1 fails for LineSegment/LineSegment"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), LineSegment.new(2.0, 2.0, 3.0, 3.0)).eval_prog([]) == LineSegment.new(2.0, 2.0, 3.0, 3.0))
  puts "Intersect test #2 fails for LineSegment/LineSegment"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), LineSegment.new(-1.0, -1.0, 3.0, 3.0)).eval_prog([]) == LineSegment.new(1.0, 1.0, 3.0, 3.0))
  puts "Intersect test #3 fails for LineSegment/LineSegment"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), LineSegment.new(2.0, 2.0, 5.0, 5.0)).eval_prog([]) == LineSegment.new(2.0, 2.0, 4.0, 4.0))
  puts "Intersect test #4 fails for LineSegment/LineSegment"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), LineSegment.new(4.0, 4.0, 5.0, 5.0)).eval_prog([]) == Point.new(4.0, 4.0))
  puts "Intersect test #5 fails for LineSegment/LineSegment"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 4.0, 4.0), LineSegment.new(-4.0, -4.0, 1.0, 1.0)).eval_prog([]) == Point.new(1.0, 1.0))
  puts "Intersect test #6 fails for LineSegment/LineSegment"
end
if not (Intersect.new(LineSegment.new(2.0, 2.0, 3.0, 3.0), LineSegment.new(1.0, 1.0, 5.0, 5.0)).eval_prog([]) == LineSegment.new(2.0, 2.0, 3.0, 3.0))
  puts "Intersect test #7 fails for LineSegment/LineSegment"
end

# intersection between two vertical LineSegments
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), LineSegment.new(1.0, 4.1, 1.0, 5.0)).eval_prog([]).class == NoPoints.new.class)
  puts "Intersect test #8 fails for LineSegment/LineSegment"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), LineSegment.new(1.0, 2.0, 1.0, 3.0)).eval_prog([]) == LineSegment.new(1.0, 2.0, 1.0, 3.0))
  puts "Intersect test #9 fails for LineSegment/LineSegment"
  puts Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), LineSegment.new(1.0, 2.0, 1.0, 3.0)).eval_prog([]).class
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), LineSegment.new(1.0, -1.0, 1.0, 3.0)).eval_prog([]) == LineSegment.new(1.0, 1.0, 1.0, 3.0))
  puts "Intersect test #10 fails for LineSegment/LineSegment"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), LineSegment.new(1.0, 2.0, 1.0, 5.0)).eval_prog([]) == LineSegment.new(1.0, 2.0, 1.0, 4.0))
  puts "Intersect test #11 fails for LineSegment/LineSegment"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), LineSegment.new(1.0, 4.0, 1.0, 5.0)).eval_prog([]) == Point.new(1.0, 4.0))
  puts "Intersect test #12 fails for LineSegment/LineSegment"
end
if not (Intersect.new(LineSegment.new(1.0, 1.0, 1.0, 4.0), LineSegment.new(1.0, -4.0, 1.0, 1.0)).eval_prog([]) == Point.new(1.0, 1.0))
  puts "Intersect test #136 fails for LineSegment/LineSegment"
end
if not (Intersect.new(LineSegment.new(1.0, 2.0, 1.0, 3.0), LineSegment.new(1.0, 1.0, 1.0, 5.0)).eval_prog([]) == LineSegment.new(1.0, 2.0, 1.0, 3.0))
  puts "Intersect test #14 fails for LineSegment/LineSegment"
end