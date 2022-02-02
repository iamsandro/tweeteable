class Like < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :tweet, counter_cache: true

  # Validations
end
