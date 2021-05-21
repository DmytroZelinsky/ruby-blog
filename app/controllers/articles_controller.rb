class ArticlesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [ :index , :search]
  def index
    @articles = Article.all.paginate(page: params[:page], per_page: 4)
    @q = Article.ransack(params[:q])
    
  end
  
  def search
    @q = Article.ransack(params[:q])
    @articles = @q.result
  end

  def filter
    @articles = Article.where(category: params[:category])
  end

  def show
    @article = Article.find(params[:id])
    @articles = Article.all
    @likes = @article.likes
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    notice
    redirect_to root_path
  end
  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :image, :user_id, :category)
    end
    
    
end
