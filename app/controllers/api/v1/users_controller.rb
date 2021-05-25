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
    render json: { user: @user }
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.fetch(:users).permit(:email, :name)
  end
end

