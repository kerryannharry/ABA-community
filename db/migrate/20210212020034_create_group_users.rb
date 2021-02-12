class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.references :user
      t.references :group

      t.timestamps null: false
    end
  end
end
