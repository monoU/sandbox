class Search::Card < Search::Base

  attr_accessor :name, :expansion, :types, :rarity

  def match
    results = ::Card.all
    results = results.where("name LIKE :key OR name_ja LIKE :key", key: "\%#{name}\%") if name.present?
    results = results.where(expansion: expansion) if expansion.present?
    results = results.where(types: types) if types.present?
    results = results.where(rarity: rarity) if rarity.present?
    results
  end
end