class CreateImages < ActiveRecord::Migration[8.1]
  def change
    create_table :images do |t|
      t.string :name, null: false
      t.string :file, null: false
      t.references :theme, null: false, foreign_key: true
      t.integer :ave_value, null: false, default: 0

      t.timestamps
    end

    add_index :images, :file, unique: true
  end
end
