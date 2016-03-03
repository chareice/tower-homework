require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before do
    user = create(:user)
    @team = Team.create(name: 'Apple Watch设计团队')
    sign_in user
  end

  it '可以访问index' do
    get :index, team_id: @team.id
    expect(response).to have_http_status(200)
  end
end
