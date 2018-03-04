class Card < ApplicationRecord
  validates :number, uniqueness: { scope: [:expansion] }, numericality: { greater_than: 0 }

end
