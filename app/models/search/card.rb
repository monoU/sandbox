class Search::Card < Search::Base

  attr_accessor :expansion, :types

  def match
    results = ::Card.all
    results = results.where(expansion: expansion) if expansion.present?
    results = results.where(types: types) if types.present?
    results
  end
end