class DiscussionMailer < ApplicationMailer
	default from: 'Forum Template <notifications@forum-template.com>'

  def new_discussion_notification(user, discussion)
    @user = user
		@discussion = discussion

    mail(to: user.email, subject: 'New discussion')
  end
end
