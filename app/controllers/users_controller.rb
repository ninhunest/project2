class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i(show edit update)
  before_action :load_user, only: %i(show edit update)

  def index; end

  def show
    @posts = @user.posts.sort_by_updated.paginate page: params[:page],
    per_page: 5
  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    redirect_to root_path
  end
end
