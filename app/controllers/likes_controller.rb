class LikesController < ApplicationController
  skip_before_action :require_login

  def create
    @topic = Topic.find(params[:topic_id])
    Like.create!(topic_id: @topic.id)
  end
end
