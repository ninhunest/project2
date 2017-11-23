class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: %i(edit update)

  def index
    if user_signed_in?
      @posts = current_user.posts.sort_by_updated.paginate page: params[:page],
        per_page: 5
    else
      @posts = Post.select(:id, :title, :content, :user_id, :updated_at, :picture)
      .sort_by_updated.paginate page: params[:page],
        per_page: 5
    end
  end

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t "create_post"
      redirect_to @post
    else
      flash.now[:danger] = t "failed_create"
      redirect_to root_url
    end
  end

  def edit; end

  def update
    if @post.update_attributes post_params
      flash[:success] = t "update_success"
      redirect_to @post
    else
      flash.now[:danger] = t "update_failed"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".user_deleted"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit :title, :content, :picture, :list_tags
  end

  def load_post
    @post = Post.find_by id: params[:id]

    return if @post
    redirect_to root_path
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end
