class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  def index
    @appointments = Appointment.all
      if current_user.appointments.any?
        current_user.appointments.each do |apmt|
          @date = params[:date] ? Date.parse(params[:date]) : apmt.date
        end
      else
        @date = params[:date] ? Date.parse(params[:date]) : Date.today
      end
  end

  def show
  end

  def new
    if current_user.appointments.count >= 1
      @apmt = current_user.appointments
      @apmt.each do |f|
        redirect_to root_url, alert:  "You already have an appointment on #{f.date.strftime("#{f.date.day.ordinalize} %B, %Y")}"
      end
    end
    @appointment = Appointment.new
  end

  def edit
  end


  def create
    @appointment = current_user.appointments.build(appointment_params)
    @shiva = Appointment.find_by_date(@appointment.date)

      if @shiva
        redirect_to new_appointment_path, alert:  "No slots available for the chosen date"
      else 
        respond_to do |format|
          if @appointment.save
            format.html { redirect_to @appointment, notice: 'Your appointment has been successfully scheduled.' } 
            format.json { render :show, status: :created, location: @appointment }
          else
            format.html { render :new }
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
          end
        end
      end
  end

 
  def update
    @shiva = Appointment.find_by_date(@appointment.date)

      if @shiva
        redirect_to @appointment, alert:  "No slots available for the chosen date"
      else 
        respond_to do |format|
          if @appointment.update(appointment_params)
            format.html { redirect_to account_path, notice: 'Appointment was successfully updated.' }
            format.json { render :show, status: :ok, location: @appointment }
          else
            format.html { render :edit }
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
          end
        end
      end
  end

  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to new_appointment_path, notice: 'Earlier appointment was successfully destroyed. You can fix a new appointment below.' }
      format.json { head :no_content }
    end
  end

  def my_account
    @apmt = current_user.appointments

  end

  private

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:date, :slots)
    end
end
