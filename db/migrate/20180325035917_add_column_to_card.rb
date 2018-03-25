class AddColumnToCard < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :creature_type, :string, :after => :toughness
  end
end
