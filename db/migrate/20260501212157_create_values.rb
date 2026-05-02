class CreateValues < ActiveRecord::Migration[8.1]
  def change
    create_table :values do |t|
      t.references :user, null: false, foreign_key: true
      t.references :image, null: false, foreign_key: true
      t.integer :value, null: false

      t.timestamps
    end

    add_index :values, [ :user_id, :image_id ], unique: true
  end
end
