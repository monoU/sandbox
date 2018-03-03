class CreateExpansions < ActiveRecord::Migration[5.1]
  def change
    create_table :expansions do |t|
      t.string :name
      t.string :abbr
      t.date :released_at

      t.timestamps
    end
  end
end
