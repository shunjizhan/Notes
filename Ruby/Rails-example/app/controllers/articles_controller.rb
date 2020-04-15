# the article controller class will automatically have access to Article class, and there are some built in static method for Article class (which is a active record class), such as Article.new, Article.all, etc..
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def show
    # the reason for this line is that otherwise @article would be nil in our view, and calling @article.errors.any? would throw an error.
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # create a article instance to represent current article
    @article = Article.new(article_params)

    if @article.save
      # redirect to current articles default show action
      redirect_to @article
    else
      # we use render here instead of redirect_to, so that the @article object is passed back to the new template when it is rendered
      render 'new'
    end
  end

  def update
    # find the article instance we want to edit
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      # params here is a key word, it contains the params each time a form in submitted. It is basically the params after ? in url, such as /url?id=3
      params.require(:article).permit(:title, :text)
    end
end
