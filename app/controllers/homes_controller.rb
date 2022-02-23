class HomesController < ApplicationController
  skip_before_action :require_login
  def index
    @tags = Tag.all
  end
end
