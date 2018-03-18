class Card < ApplicationRecord
  validates :number, uniqueness: { scope: [:expansion] }, numericality: { greater_than: 0 }

  enum rarity:{神話レア: 0, レア: 1, アンコモン: 2, コモン: 3}
end
