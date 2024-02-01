class CreateChandrayans < ActiveRecord::Migration[6.1]
  def change
    create_table :chandrayans do |t|
      t.integer :x
      t.integer :y
      t.integer :z
      t.string :direction
      
      t.timestamps
    end
  end
end
