class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.string :name, null: false, default: ""
    end
  end
end
