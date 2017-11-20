class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i(show edit update)
  before_action :load_user, only: %i(show edit update)

  def index; end

  def show; end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    redirect_to root_path
  end
end
