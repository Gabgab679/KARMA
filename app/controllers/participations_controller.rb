class ParticipationsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    new_participant = Participation.new
    new_participant.event = event
    new_participant.user = current_user
    if new_participant.save
      redirect_to event, flash: { alert: 'You just registered to this event! Wait for the host confirmation' }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    redirect_to my_events, flash: { alert: 'You just registered to this event! Wait for the host confirmation' }
  end

  def destroy
    @event = Event.find(params[:event_id])
  end
end
