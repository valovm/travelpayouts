# frozen_string_literal: true
module Programs
  # Autocomplete
  class Autocomplete
    def self.call(term)
      return Program.where('1 = 0') if term.size < ENV['PROGRAMS_AUTOCOMPLETE_MIN_LENGTH'].to_i

      Program.where('title LIKE :term', term: "%#{term}%").order(count_of_users: :DESC)
    end
  end
end