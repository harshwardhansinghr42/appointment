class CreateCheckupAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :checkup_appointments, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.references :user, type: :uuid, index: true, foreign_key: true
      t.references :doctor, type: :uuid, index: true, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
    end
  end
end
