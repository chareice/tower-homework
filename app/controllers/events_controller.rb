class EventsController < ApplicationController
  def index
    current_user_project_ids = current_user.projects.map(&:id)
    @team = Team.find(params[:team_id])
    events_data = Event.where(project_id: current_user_project_ids)
                   .order('created_at desc')
                   .page(params[:page]).per(50)
    @events = events_data.to_json

    respond_to do |format|
      format.html
      format.json {
        data = {
          current_page: events_data.current_page,
          total_page: events_data.total_pages,
          data: events_data
        }
        render :json => data
      }
    end
  end
end
