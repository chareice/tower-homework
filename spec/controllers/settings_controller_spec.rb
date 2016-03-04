require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  it '可以访问本人在项目中可访问的项目设置页面' do
    user = create(:user)
    sign_in user

    team = create(:team)
    get :show, team_id: team.id
    expect(response).to have_http_status(200)
  end
end
