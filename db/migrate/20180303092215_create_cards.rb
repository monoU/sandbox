class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.integer  :number
      t.string   :name
      t.string   :name_ja
      t.string   :cost
      t.string   :expansion
      t.string   :colour
      t.string   :types
      t.integer  :power
      t.integer  :toughness
      t.string   :artist
      t.string   :rarity
      t.timestamps
    end
  end
end
