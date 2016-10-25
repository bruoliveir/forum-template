require 'test_helper'

class DiscussionsShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
    @discussion = Discussion.create(:title => "1.", :body => "body", :user => @user)
  end

  test "should show root discussion" do
    get discussion_path(@discussion)

    assert_equal JSON.parse(response.body).first["id"], @discussion.id
  end

  test "should show non-root discussion" do
    discussion_1_2 = Discussion.create(:title => "1.2.", :body => "body", :user => @user, :path => @discussion.path)

    get discussion_path(discussion_1_2)

    assert_equal JSON.parse(response.body).first["id"], discussion_1_2.id
  end
end
