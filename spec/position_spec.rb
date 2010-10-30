
require_relative "../lib/position"

describe "Position" do
  describe ".rot" do
    it "returns rotated matrix" do
      Position.rot(Matrix[[2, 3]], 0).should eq Matrix[[2, 3]]
      Position.rot(Matrix[[2, 3]], 1).should eq Matrix[[-3, 2]]
      Position.rot(Matrix[[2, 3]], 2).should eq Matrix[[-2, -3]]
      Position.rot(Matrix[[2, 3]], 3).should eq Matrix[[3, -2]]
    end
  end

  describe ".relative" do
    it "returns relative position" do
      Position.relative([1, 2], [4, 1], 0).should eq [5, 3]
      Position.relative([1, 2], [4, 1], 1).should eq [0, 6]
      Position.relative([1, 2], [4, 1], 2).should eq [-3, 1]
      Position.relative([1, 2], [4, 1], 3).should eq [2, -2]
    end
  end
end

