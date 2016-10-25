class DiscussionsController < ApplicationController

  ITEMS_PER_PAGE = 10

  def index
    most_recent_per_root = Discussion.most_recent_per_root.limit(ITEMS_PER_PAGE).offset((params[:page].to_i - 1) * ITEMS_PER_PAGE)

    @last_updated_discussions = most_recent_per_root.map do |d|
      d.ancestors.limit(1).first
    end

    render json: @last_updated_discussions
  end

  def show
    @self_and_descendants = Discussion.find(params[:id]).descendants

    render json: @self_and_descendants
  end

  def create
    @discussion = Discussion.new(discussion_params)

    if @discussion.save
      render json: @discussion
    else
      render json: { error: @discussion.errors }
    end
  end

  private

    def discussion_params
      params.require(:discussion).permit(:user_id, :title, :body, :path)
    end
end
