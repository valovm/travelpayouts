# frozen_string_literal: true

module ApiHelpers
  # @return [Object]
  def json_body
    JSON.parse(response.body)
  end
end
