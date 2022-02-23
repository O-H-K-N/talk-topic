class TagsController < ApplicationController
  def index
    @tags = Tag.all
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