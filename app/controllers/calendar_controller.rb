class CalendarController < ApplicationController
  
  
  def show
    @appointments = Appointment.all
    if user_signed_in?
    	if current_user.appointments.any?
	    	current_user.appointments.each do |apmt|
	    		@date = params[:date] ? Date.parse(params[:date]) : apmt.date
	    	end
	    else
	    	@date = params[:date] ? Date.parse(params[:date]) : Date.today
	    end 
    else
    	@date = params[:date] ? Date.parse(params[:date]) : Date.today
	end
  end
end
