class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice] = "Article was created"
      redirect_to article_path(@article)
    else
      render "new"
    end
  end

  def update
  end

  def edit
    @article = Article.find(params[:id])
  end
end 
