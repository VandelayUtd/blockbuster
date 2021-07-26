class CreateMembersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :name

    end
  end
end
