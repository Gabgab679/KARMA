class ParticipationsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    new_participant = Participation.new
    new_participant.event = event
    new_participant.user = current_user
    new_participant.status = "Pending"
    if new_participant.save
      redirect_to event_path(event), flash: { alert: 'You just registered to this event! Wait for the host confirmation' }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @participation = Participation.find(params[:id])
    @participation.status = "Accepted"
    @participation.save
    redirect_to my_events_path, flash: { alert: 'Registration accepted! One more user joined your event' }
  end

  def destroy
    participation = Participation.find(params[:id]) ##les params sont inversés!!! pas le temps de modifier
    participation.destroy

    redirect_to my_events_path, notice: "You've cancelled this registration"
  end

  def cancel
    event = Event.find(params[:id])
    participation = Participation.find(params[:event_id])
    participation.destroy

    redirect_to event_path(event)
  end
end
