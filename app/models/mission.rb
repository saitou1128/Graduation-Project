class Mission < ApplicationRecord
  belongs_to :station
  has_many :stamps
end
