# frozen_string_literal: true

class Api::V1::ProgramsController < ApplicationController
  before_action :set_program, only: %i[show]

  # GET api/v1/programs
  def index
    programs = Program.all.page(page)
    render json: {programs: {current_page: programs.current_page,
                             pages: programs.total_pages,
                             count: programs.count,
                             items: programs,
                             is_last: programs.last_page?}}
  end

  # GET api/v1/programs/autocomplete
  def autocomplete
    programs = Programs::Autocomplete.call(params[:term]).page(page)
    render json: {programs: {current_page: programs.current_page,
                             pages: programs.total_pages,
                             count: programs.count,
                             items: programs,
                             is_last: programs.last_page?}}
  end

  private

  def set_program
    @program = Program.find params[:id]
  end

end
