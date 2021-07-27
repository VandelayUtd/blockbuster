class CreateMembersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :username
      t.string :password_digest
    end
  end
end
