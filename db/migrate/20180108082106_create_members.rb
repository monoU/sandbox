class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :name
      t.string :user_name
      t.integer :age
      t.string :address
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
