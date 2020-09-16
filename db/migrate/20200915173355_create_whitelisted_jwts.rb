# frozen_string_literal: true

class CreateWhitelistedJwts < ActiveRecord::Migration[6.0]
  def change
    create_table :whitelisted_jwts, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.string :jti, null: false
      t.string :userable_type, null: false
      t.uuid :userable_id, null: false
      t.timestamps
    end
    add_index :whitelisted_jwts, :jti, unique: true
  end
end
