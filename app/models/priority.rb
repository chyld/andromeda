class Priority < ActiveRecord::Base
  validates :name, :value, presence: true
  validates :name, length: { in: 3..8 }
  validates :value, numericality: { only_integer: true }

  scope :important, lambda { order('value desc') }
end
