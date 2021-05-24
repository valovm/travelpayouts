class ApplicationController < ActionController::API

  private

  def page
    params[:page]&.to_i&.negative? ? 1 : params[:page]
  end
end
