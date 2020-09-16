class CheckupAppointmentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :doctor_id, :start_time, :end_time

  def start_time
    object.start_time.strftime('%d-%m-%Y %I:%M%p')
  end

  def end_time
    object.end_time.strftime('%d-%m-%Y %I:%M%p')
  end
end
