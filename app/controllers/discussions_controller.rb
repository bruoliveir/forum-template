class DiscussionsController < ApplicationController

  def index
    @root_discussions = Discussion.roots

    sorted_root_discussions = @root_discussions.sort do |a, b|
      b.self_and_descendents.sort_by(&:created_at).last.created_at <=>
      a.self_and_descendents.sort_by(&:created_at).last.created_at
    end

    items_per_page = 10

    first = (params[:page].to_i - 1) * items_per_page
    last = first + items_per_page - 1

    render json: sorted_root_discussions[first..last]
  end

  def show
    @root_discussion = Discussion.roots.find(params[:id])
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
      params.require(:discussion).permit(:parent_id, :user_id, :title, :body)
    end
end
