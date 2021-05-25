# frozen_string_literal: true

class Api::V1::Users::ProgramsController < ApplicationController
  before_action :subscribe_service, only: %i[create destroy]

  # GET api/v1/users/:user_id/programs
  def index
    programs = @user.programs.page(page)
    render json: {
      programs: {
        current_page: programs.current_page,
        pages: programs.total_pages,
        count: programs.count,
        items: programs,
        is_last: programs.last_page?
      }
    }
  end

  # POST api/v1/users/:user_id/programs
  def create
    program = User.find subscribe_params[:program_id]
    subscribe_service.subscribe program, @user
  end

  # DELETE api/v1/users/:user_id/programs/:id
  def destroy
    subscribe_service.unsubscribe @program, @user
  end

  private

  def set_user
    @user = Program.find params[:user_id]
  end

  def set_program
    @program = Program.find params[:id]
  end

  def subscribe_params
    params.fetch(:subscribe).permit(:program_id)
  end

  def subscribe_service
    Programs::Subscription.new
  end

end
