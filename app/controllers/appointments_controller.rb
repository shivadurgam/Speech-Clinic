class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!


  # GET /appointments
  # GET /appointments.json
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

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    if current_user.appointments.count >= 1
      @apmt = current_user.appointments
      @apmt.each do |f|
        redirect_to root_url, alert:  "You already have an appointment on #{f.date.strftime("#{f.date.day.ordinalize} %B, %Y")}"
      end
    end
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = current_user.appointments.build(appointment_params)
    if current_user.appointments.count >= 1
      redirect_to @appointment, alert:  "You already have an appointment"
    else 
      respond_to do |format|
        if @appointment.save
          format.html { redirect_to account_path, notice: 'Appointment was successfully created.' }
          format.json { render :show, status: :created, location: @appointment }
        else
          format.html { render :new }
          format.json { render json: @appointment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
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

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my_account
    @apmt = current_user.appointments

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:date)
    end
end
