class ApplicationController < ActionController::API

  rescue_from(StandardError) do |e|
    p e.message
    render json: {
        errors: [{code: 'error', title: I18n.t('errors.common.title'), detail: I18n.t('errors.common.detail')}],
    }, status: 500
  end

  rescue_from(ActiveRecord::RecordNotFound) do |e|
    render json: {
        errors: [{code: 'error', title: I18n.t('errors.not_found.title'), detail: I18n.t('errors.not_found.detail')}],
    }, status: 404
  end


  rescue_from(BaseError) do |e|
    render json: {errors: [e]}, status: :bad_request
  end

  private

  def page
    params[:page]&.to_i&.negative? ? 1 : params[:page]
  end
end
