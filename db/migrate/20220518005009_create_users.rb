class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.boolean :active
      t.string :name
      t.string :login
      t.string :email

      t.timestamps
    end
  end
end
