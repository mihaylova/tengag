class TagsController < ApplicationController
  #layout "empty", only: :index


  def show
    @tag = Tag.find_by_name(params[:tag])
    @posts = @tag.posts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def index
    @tags = Tag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end

  def search 
    if params[:tags].present?
      @tags = Tag.where(name: params[:tags])
      @posts = Post.joins(:tags).where('`tags`.id IN (?)', @tags.map(&:id)).uniq
    else
      @tags = Tag.all
      @posts = Post.joins(:tags).where('`tags`.id IN (?)', @tags.map(&:id)).uniq
    end
    
    @posts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end


  end
end
