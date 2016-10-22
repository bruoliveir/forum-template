require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
  def setup
    @user = users(:example)
    @discussion = Discussion.create(:title => "Root thread", :body => "Body content", :user => @user)
  end

  test "should not be deleted" do
    assert_raises(ActiveRecord::ReadOnlyRecord) do
      @discussion.destroy
    end
  end

  test "should not be updated" do
    assert_raises(ActiveRecord::ReadOnlyRecord) do
      @discussion.update_attributes(:title => "Updated title")
    end
  end

  test "should be valid" do
    assert @discussion.valid?
  end

  test "title should be present" do
    @discussion.title = "     "
    assert_not @discussion.valid?
  end

  test "body should be present" do
    @discussion.body = "     "
    assert_not @discussion.valid?
  end

  test "user should be present" do
    @discussion.user = nil
    assert_not @discussion.valid?
  end

  test "should have descendents 1 level deep" do
    subthreadA = Discussion.create(:title => "Root.A", :body => "Content", :user => @user, :parent => @discussion)
    subthreadB = Discussion.create(:title => "Root.B", :body => "Content", :user => @user, :parent => @discussion)
    
    assert @discussion.descendents == [subthreadA, subthreadB]
  end

  test "should have descendents 2 levels deep" do
    subthreadA = Discussion.create(:title => "Root.A", :body => "Content", :user => @user, :parent => @discussion)
    subthreadB = Discussion.create(:title => "Root.A.B", :body => "Content", :user => @user, :parent => subthreadA)
    
    assert @discussion.descendents == [subthreadA, subthreadB]
  end

  test "should have descendents 3 levels deep" do
    subthreadA = Discussion.create(:title => "Root.A", :body => "Content", :user => @user, :parent => @discussion)
    subthreadB = Discussion.create(:title => "Root.A.B", :body => "Content", :user => @user, :parent => subthreadA)
    subthreadC = Discussion.create(:title => "Root.A.B.C", :body => "Content", :user => @user, :parent => subthreadB)
    
    assert @discussion.descendents == [subthreadA, subthreadB, subthreadC]
  end
end
