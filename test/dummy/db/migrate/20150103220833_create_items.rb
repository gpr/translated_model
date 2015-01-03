class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :key

      t.timestamps null: false
    end
  end
end
