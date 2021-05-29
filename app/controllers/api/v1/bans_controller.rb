# frozen_string_literal: true

class Api::V1::BansController < ApplicationController

  # POST api/v1/bans
  def ban
    bans_service.in_ban
    render json: {message: I18n.t('programs.bans.message.user_is_banned', program_name: @program.title)}
  end

  # DELETE api/v1/users/:user_id/programs/:id/ban
  def unban
    bans_service.out_ban
    render json: {message: I18n.t('programs.bans.message.user_is_unbanned', program_name: @program.title)}
  end

  private

  def ban_params
    params.require(:ban).permit(:program_id, :user_id)
  end

  def bans_service
    @user = User.find ban_params[:user_id]
    @program = Program.find ban_params[:program_id]

    Programs::Bans.new(@program, @user)
  end
end
