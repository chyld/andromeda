class CreatePriorities < ActiveRecord::Migration
  def change
    create_table :priorities do |t|
      t.string :name, null: false, limit: 25, index: true
      t.integer :value, null: false, default: 0
      t.timestamps null: false
    end
  end
end
