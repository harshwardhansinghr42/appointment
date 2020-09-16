class Api::V1::CheckupAppointmentsController < Api::V1::ApplicationController
  before_action :authenticate_user!
  before_action :checkup_appointment, only: [:update]

  def index
    page = params[:page]&.to_i || 1
    appointments = CheckupAppointment.all
    appointments = appointment_by_status(appointments)
    appointments = appointments_by_time_span(appointments)
    appointments = appointments_by_doctor(appointments)
    render json: appointments.paginate(page: page), status: :ok
  rescue StandardError => e
    Rails.logger.error(e)
    head :unprocessable_entity
  end

  def update
    if @checkup_appointment.update(user_id: @current_user.id)
      render json: { message: (I18n.t 'checkup_appointments.created').to_s },
             status: :ok
    end
  end

  swagger_controller :checkup_appointments, 'Appointment', resource_path: '/api/v1/checkup_appointments'

  swagger_api :index do
    summary 'Fetch Appointments'
    param :header, :Authorization, :string, :required, 'Auth Token'
    param :query, 'start_date', :string, :required, 'Start date - yyyy-mm-dd'
    param :query, 'end_date', :string, :optional, 'End date - yyyy-mm-dd'
    param :query, 'doctor_id', :string, :optional, 'Appointments of specific doctor'
    param :query, 'booked', :boolean, :required, 'Appointment Booked or Slot is free'
    param :query, 'page', :integer, :optional, 'Page number'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Update/Schedule Appointment from given appointments'
    param :header, :Authorization, :string, :required, 'Auth Token'
    param :path, 'id', :string, :required, 'Appointment id'
    response :unauthorized
  end

  private

  def checkup_appointment
    @checkup_appointment ||= CheckupAppointment.find(params[:id])
  end

  def appointment_by_status(appointments)
    if params[:booked] == 'true'
      appointments.booked
    else
      appointments.free
    end
  end

  def appointments_by_time_span(appointments)
    start_time = DateTime.parse(params[:start_date])
    end_time = if params[:start_date].present? && params[:end_date].present?
                 DateTime.parse(params[:end_date]) + 1
               else
                 start_time + 1
               end
    appointments.where('start_time >= ? AND end_time < ?', start_time, end_time)
  end

  def appointments_by_doctor(appointments)
    appointments = appointments.where(doctor_id: params[:doctor_id]) unless params[:doctor_id].blank?
    appointments
  end
end
