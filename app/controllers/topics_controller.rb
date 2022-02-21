class TopicsController < ApplicationController
  skip_before_action :require_login

  def index;
    @topics = Topic.all.order(created_at: :desc)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to topics_path, success: t('.success')
    else
      render :new
    end
  end

  private

  def topic_params
    params.require(:topic).permit(
      :user_name,
      :title
    )
  end

end
