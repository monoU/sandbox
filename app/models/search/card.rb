class Search::Card < Search::Base

  attr_accessor :expansion, :types, :rarity

  def match
    results = ::Card.all
    results = results.where(expansion: expansion) if expansion.present?
    results = results.where(types: types) if types.present?
    results = results.where(rarity: rarity) if rarity.present?
    results
  end
end