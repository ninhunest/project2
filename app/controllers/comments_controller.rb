class CommentsController < ApplicationController
  before_action :load_post
  before_action :load_comment, only: [:update, :destroy]

  def create
    @comment = @post.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = t "create_success"
          redirect_to request.referrer
        end
        format.js
      end
    else
      flash[:danger] = t "error"
      redirect_to request.referrer
    end
  end

  def update
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.html do
          flash[:success] = t "create_success"
          redirect_to request.referrer
        end
        format.js
      end
    else
      flash[:danger] = t "error"
      redirect_to request.referrer
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t ".delete_success"
          redirect_to request.referrer
        end
        format.js
      end
    else
      flash[:danger] = t ".failed_delete"
      redirect_to request.referrer
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_post
    @post = Post.find_by id: params[:post_id]
  end

  def load_comment
    @comment = @post.comments.find_by id: params[:id]
  end
end
