class TagsController < ApplicationController
  skip_before_action :require_login, only: :show

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by(id: params[:id])
    if @tag
      topics = @tag.topics.all
      if params[:type] == 'popular'
        topics = topics.sort {|a,b| b.likes.size <=> a.likes.size}
        @topics = Kaminari.paginate_array(topics).page(params[:page]).per(10)
      else
        @topics = topics.order(created_at: :desc).page(params[:page]).per(10)
      end
    else
      redirect_to root_path
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path, success: t('.success', name: @tag.name)
    else
      render :new
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy!
    redirect_to tags_path, success: t('.success', name: tag.name)
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end