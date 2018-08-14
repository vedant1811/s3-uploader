class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets do |t|
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
