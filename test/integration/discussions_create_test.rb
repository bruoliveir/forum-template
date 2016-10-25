require 'test_helper'

class DiscussionsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
    @discussion = Discussion.create(:title => "1.", :body => "body", :user => @user)
  end

  test "should save valid root discussion" do
    assert_difference 'Discussion.count', 1 do
      post discussions_path, params: { discussion: { title: "#.", body: "body", user_id: @user.id } }
    end
  end

  test "should save valid branch discussion" do
    assert_difference 'Discussion.count', 1 do
      post discussions_path, params: { discussion: { title: "#.", body: "body", user_id: @user.id, :path => @discussion.path } }
    end
  end

  test "should not save invalid discussion" do
    assert_no_difference 'Discussion.count' do
      post discussions_path, params: { discussion: { title: "", body: "", user_id: nil } }
    end
    assert JSON.parse(response.body).key?("error")
  end
end
