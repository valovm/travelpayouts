class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  paginates_per ENV['PAGE_PER']
end
