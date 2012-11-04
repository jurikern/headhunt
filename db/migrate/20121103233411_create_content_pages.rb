class CreateContentPages < ActiveRecord::Migration
  def change
    create_table :content_pages do |t|
      t.references :contentable, polymorphic: true
      t.text :html, null: false, default: ''

      t.timestamps
    end

    add_index :content_pages, [:contentable_id, :contentable_type], unique: true
  end
end
