# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  # GET api/v1/users
  def index
    users = User.all.page(page)
    render json: {
      users: {
          current_page: users.current_page,
          pages: users.total_pages,
          count: users.count,
          items: users,
          is_last: users.last_page?
      }
    }
  end

  # GET api/v1/users/:id
  def show
    render json: {user: @user}
  end

  # POST api/v1/users
  def create
    user = User.new user_params
    if user.save
      render json: {user: user}
    else
      render json: {errors: user.errors}, status: :bad_request
    end
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :name)
  end
end

