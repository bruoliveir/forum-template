require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
  def setup
    @root = Discussion.create(:title => "Root thread")
  end

  test "should not be deleted" do
    assert_raises(ActiveRecord::ReadOnlyRecord) do
      @root.destroy
    end
  end

  test "should not be updated" do
    assert_raises(ActiveRecord::ReadOnlyRecord) do
      @root.update_attributes(:title => "Updated title")
    end

    assert_raises(ActiveRecord::ReadOnlyRecord) do
      @root.title = "Updated title"
      @root.save
    end
  end

  test "should have descendents 1 level deep" do
    subthreadA = Discussion.create(:title => "Root.A", :parent => @root)
    subthreadB = Discussion.create(:title => "Root.B", :parent => @root)
    
    assert @root.descendents == [subthreadA, subthreadB]
  end

  test "should have descendents 2 levels deep" do
    subthreadA = Discussion.create(:title => "Root.A", :parent => @root)
    subthreadB = Discussion.create(:title => "Root.A.B", :parent => subthreadA)
    
    assert @root.descendents == [subthreadA, subthreadB]
  end

  test "should have descendents 3 levels deep" do
    subthreadA = Discussion.create(:title => "Root.A", :parent => @root)
    subthreadB = Discussion.create(:title => "Root.A.B", :parent => subthreadA)
    subthreadC = Discussion.create(:title => "Root.A.B.C", :parent => subthreadB)
    
    assert @root.descendents == [subthreadA, subthreadB, subthreadC]
  end
end
