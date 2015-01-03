# This migration comes from translated_model (originally 20150103191317)
class CreateTranslatedModelTranslations < ActiveRecord::Migration
  def change
    create_table :translated_model_translations do |t|
      t.string :key, null: false
      t.string :locale, null: false
      t.text :value, null: false

      t.timestamps null: false
    end
    add_index :translated_model_translations, :key, unique: true
    add_index :translated_model_translations, :locale
  end
end
