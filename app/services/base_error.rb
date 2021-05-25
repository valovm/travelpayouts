# frozen_string_literal: true

class BaseError < StandardError
  attr_reader :code, :title, :detail

  def initialize(msg = nil, title = nil, detail = nil)
    @code = msg
    @title = title
    @detail = detail
    super(msg)
  end

  def as_json(*)
    {
      code: code, title: title, detail: detail
    }
  end

end
