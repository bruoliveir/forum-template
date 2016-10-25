require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
  def setup
    @user = users(:example)
    @discussion = Discussion.create(:title => "1.", :body => "body", :user => @user)
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

  test "should have descendants 1 level deep" do
    discussion_1_2 = Discussion.create(:title => "1.2.", :body => "body", :user => @user, :path => @discussion.path)
    discussion_1_3 = Discussion.create(:title => "1.3.", :body => "body", :user => @user, :path => @discussion.path)
    
    assert @discussion.descendants == [@discussion, discussion_1_2, discussion_1_3]
  end

  test "should have descendants 2 levels deep" do
    discussion_1_2 = Discussion.create(:title => "1.2.", :body => "body", :user => @user, :path => @discussion.path)
    discussion_1_2_3 = Discussion.create(:title => "1.2.3.", :body => "body", :user => @user, :path => discussion_1_2.path)
    
    assert @discussion.descendants == [@discussion, discussion_1_2, discussion_1_2_3]
  end

  test "should have descendants 3 levels deep" do
    discussion_1_2 = Discussion.create(:title => "1.2.", :body => "body", :user => @user, :path => @discussion.path)
    discussion_1_2_3 = Discussion.create(:title => "1.2.3.", :body => "body", :user => @user, :path => discussion_1_2.path)
    discussion_1_2_3_4 = Discussion.create(:title => "1.2.3.4.", :body => "body", :user => @user, :path => discussion_1_2_3.path)
    
    assert @discussion.descendants == [@discussion, discussion_1_2, discussion_1_2_3, discussion_1_2_3_4]
  end
end
