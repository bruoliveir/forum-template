class DiscussionsController < ApplicationController

  def index
    @root_discussions = Discussion.roots
    sorted_root_discussions = @root_discussions.sort do |a, b|
      b.descendents.sort_by(&:created_at).last.created_at <=> a.descendents.sort_by(&:created_at).last.created_at
    end
    render json: sorted_root_discussions
  end

  def show
  end

  def new
  end

  def create
  end
end
