require 'test_helper'

class DiscussionsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
    @discussion = Discussion.create(:title => "1.", :body => "body", :user => @user)
  end

  test "should order discussions by most recently updated" do
    discussion_2 = Discussion.create(:title => "2.", :body => "body", :user => @user)
    discussion_3 = Discussion.create(:title => "3.", :body => "body", :user => @user)
    Discussion.create(:title => "2.4.", :body => "body", :user => @user, :path => discussion_2.path)

    get discussions_path
    follow_redirect!

    assert_equal JSON.parse(response.body).map { |d| d["id"] }, [2, 3, 1]
  end
end
