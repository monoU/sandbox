class ChangeColumnToCard < ActiveRecord::Migration[5.1]
  # 変更内容
  def up
    change_column :cards, :rarity, :integer, null: false, default: 0
  end

  # 変更前の状態
  def down
    change_column :cards, :rarity, :string
  end
end
