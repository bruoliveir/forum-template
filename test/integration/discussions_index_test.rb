require 'test_helper'

class DiscussionsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
    @discussion = Discussion.create(:title => "Root discussion", :body => "Content", :user => @user)
  end

  test "should order discussions by most recent self or descendants" do
    another_discussion = Discussion.create(:title => "Another root discussion", :body => "Content", :user => @user)
    yet_another_discussion = Discussion.create(:title => "Yet another root discussion", :body => "Content", :user => @user)
    Discussion.create(:title => "Branch of another_discussion", :body => "Content", :user => @user, :parent => another_discussion)

    get discussions_path

    assert_equal JSON.parse(response.body).map { |d| d["id"] }, [2, 3, 1]
  end
end
