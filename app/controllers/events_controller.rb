class EventsController < ApplicationController
  def index
    current_user_project_ids = current_user.projects.map(&:id)
    @events = Event.where(project_id: current_user_project_ids)
                   .order('created_at desc').to_json
  end
end
