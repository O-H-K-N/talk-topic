class TopicsController < ApplicationController
  skip_before_action :require_login

  def index
    @topics = Topic.all.order(created_at: :desc).page(params[:page]).per(10)
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

  def tags
    @tag = Tag.find_by(id: params[:format])
    if @tag
      @topics = @tag.topics.all.order(created_at: :desc).page(params[:page]).per(10)
    else
      redirect_to root_path
    end
  end

  private

  def topic_params
    params.require(:topic).permit(
      :user_name,
      :title,
      tag_ids: []
    )
  end

end
