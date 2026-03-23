class Stamp < ApplicationRecord
  belongs_to :user
  belongs_to :station
  belongs_to :mission, optional: true
end
