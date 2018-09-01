class Card < ApplicationRecord
  enum rarity:{神話レア: 0, レア: 1, アンコモン: 2, コモン: 3}
end
