# frozen_string_literal: true
module Programs
  # List
  class List
    def call(search = nil)
      if search
        Program.where('title ILIKE :search', search: "%#{search}%")
      else
        Program.all
      end
    end
  end
end