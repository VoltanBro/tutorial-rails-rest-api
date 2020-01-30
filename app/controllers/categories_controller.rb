class CategoriesController < ApplicationController
  before_action :authorize_request
  before_action :post_pagination_params, only: [:index, :show]
  before_action except: [:index, :show] do
    is_role :admin
  end
  before_action :set_category, only: [:show, :update, :destroy]
  before_action only: [:edit, :update, :destroy] do
    is_owner_object @category ##your object
  end

  # GET /categories
  def index
    page = params[:page].present? ? params[:page] : 1
    per = params[:per].present? ? params[:per] : 10
    @categories = Category.published.by_date.page(page).per(per)
    param_page = {
        post_page: @post_page,
        post_per: @post_per
    }
    render json: Pagination.build_json(@categories, param_page)
  end

  # GET /categories/1
  def show
    param_page = {
        post_page: @post_page,
        post_per: @post_per
    }
    render json: @category, param_page: param_page
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.published = false
    @category.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.published.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:title, :body).merge(user_id: @current_user.id)
    end

    def post_pagination_params
      @post_page = params[:post_page].present? ? params[:post_page] : 1
      @post_per = params[:post_per].present? ? params[:post_per] : 10
    end
end
