class AddColumnTonExpansion < ActiveRecord::Migration[5.1]
  def change
    add_column :expansions, :name_ja, :string, :after => :name

    add_index :expansions, :abbr
  end
end
