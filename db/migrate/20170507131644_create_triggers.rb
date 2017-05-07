class CreateTriggers < ActiveRecord::Migration[5.1]
  def change
    create_table :triggers do |t|
      t.references :user, null: false
      t.integer :movie_id, null: false
      t.string :label, null: false

      t.timestamps
    end

    add_index :triggers, [:user_id, :movie_id, :label], unique: true
  end
end
