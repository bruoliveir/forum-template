require 'test_helper'

class DiscussionsShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
    @discussion = Discussion.create(:title => "Root thread", :body => "Body content", :user => @user)
  end

  test "unsuccessful show" do
    subthread = Discussion.create(:title => "Root.A", :body => "Content", :user => @user, :parent => @discussion)

    assert_raises(ActiveRecord::RecordNotFound) do
      get discussion_path(subthread)
    end
  end
end
