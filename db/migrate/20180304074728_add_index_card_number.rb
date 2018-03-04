class AddIndexCardNumber < ActiveRecord::Migration[5.1]
  def change
    add_index :cards, [:number, :expansion], unique: true
  end
end
