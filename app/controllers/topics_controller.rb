class TopicsController < ApplicationController
  skip_before_action :require_login

  def index
    topics = Topic.all
    if params[:type] == 'popular'
      topics = topics.sort {|a,b| b.likes.size <=> a.likes.size}
      @topics = Kaminari.paginate_array(topics).page(params[:page]).per(10)
    else
      @topics = topics.order(created_at: :desc).page(params[:page]).per(10)
    end
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
      :title,
      tag_ids: []
    )
  end

end
