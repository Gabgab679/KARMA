# app/helpers/events_helper.rb
module EventsHelper
  def remaining_spots(event)
    event.max_players - event.participations.count
  end
end
