class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.integer :user_id, :null => false, :default => 0
      t.string  :name,    :null => false, :default => ""
      t.string  :uid,     :null => false, :default => ""

      t.timestamps
    end

    add_foreign_key :providers, :users, depndent: :delete
    add_index       :providers, [:name, :uid], unique: true
  end
end
