class TopicsController < ApplicationController
  before_action :require_login, only: :destroy

  def index
    topics = Topic.all
    if params[:type] == 'popular'
      topics = topics.sort {|a,b| b.likes.size <=> a.likes.size}
      @topics = Kaminari.paginate_array(topics).page(params[:page])
    else
      @topics = topics.order(created_at: :desc).page(params[:page])
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

  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    redirect_to topics_path, success: t('.success')
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
