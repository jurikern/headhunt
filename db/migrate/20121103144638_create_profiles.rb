class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id,       null: false, default: 0
      t.string  :full_name,     null: false, default: ''
      t.date    :date_of_birth
      t.string  :email,         null: false, default: ''
      t.string  :phone,         null: false, default: ''
      t.string  :skype,         null: false, default: ''
      t.string  :www,           null: false, default: ''
      t.string  :github,        null: false, default: ''
      t.string  :country,       null: false, default: ''
      t.string  :country_code,  null: false, default: ''
      t.string  :state,         null: false, default: ''
      t.string  :state_code,    null: false, default: ''
      t.string  :city,          null: false, default: ''
      t.string  :address,       null: false, default: ''
      t.text    :description,   null: false, default: ''

      t.timestamps
    end

    add_foreign_key :profiles, :users, dependent: :delete
  end
end
