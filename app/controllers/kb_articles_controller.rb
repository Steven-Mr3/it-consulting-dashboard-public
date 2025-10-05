class KbArticlesController < ApplicationController
  include Pagy::Backend
  before_action :set_kb_article, only: [:show, :edit, :update, :destroy, :increment_views, :mark_helpful, :mark_unhelpful]

  def index
    @kb_articles = KbArticle.all

    # Search
    if params[:query].present?
      @kb_articles = @kb_articles.where("title LIKE ? OR content LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    # Filter by category
    @kb_articles = @kb_articles.by_category(params[:category]) if params[:category].present?

    # Sort
    case params[:sort]
    when 'views'
      @kb_articles = @kb_articles.most_viewed
    when 'helpful'
      @kb_articles = @kb_articles.most_helpful
    else
      @kb_articles = @kb_articles.order(created_at: :desc)
    end

    @pagy, @kb_articles = pagy(@kb_articles, limit: 12)

    # Get unique categories for filter
    @categories = KbArticle.distinct.pluck(:category).compact.sort
  end

  def show
    @kb_article.increment_views!
  end

  def new
    @kb_article = KbArticle.new
  end

  def edit
  end

  def create
    @kb_article = KbArticle.new(kb_article_params)

    if @kb_article.save
      redirect_to @kb_article, notice: 'Knowledge base article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @kb_article.update(kb_article_params)
      redirect_to @kb_article, notice: 'Knowledge base article was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kb_article.destroy
    redirect_to kb_articles_url, notice: 'Knowledge base article was successfully deleted.'
  end

  def increment_views
    @kb_article.increment_views!
    head :ok
  end

  def mark_helpful
    @kb_article.mark_helpful!
    redirect_to @kb_article, notice: 'Thank you for your feedback!'
  end

  def mark_unhelpful
    @kb_article.mark_unhelpful!
    redirect_to @kb_article, notice: 'Thank you for your feedback!'
  end

  private

  def set_kb_article
    @kb_article = KbArticle.find(params[:id])
  end

  def kb_article_params
    params.require(:kb_article).permit(:title, :content, :category)
  end
end
