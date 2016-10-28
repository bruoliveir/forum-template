require 'test_helper'

class DiscussionMailerTest < ActionMailer::TestCase
  tests DiscussionMailer

  def setup
    @user = users(:example)
    @discussion = Discussion.create(:title => "1.", :body => "body", :user => @user)
  end

  test "should queue new discussion notification email" do
    email = DiscussionMailer.new_discussion_notification(@user, @discussion)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['notifications@forum-template.com'], email.from
    assert_equal [@user.email], email.to
    assert_equal 'New discussion', email.subject
  end
end
