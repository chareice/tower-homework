require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before do
    @user = create(:user)
    sign_in @user

    @team = create(:team)
    10.times do
      @team.projects << create(:project)
    end
  end

  describe '获取团队下的项目列表' do
    it '渲染index模版' do
      get :index, team_id: @team.id
      expect(response).to render_template(:index)
    end
  end

  describe '创建新项目' do
    it '访问创建页面' do
      get :new, team_id: @team.id
      expect(response).to render_template(:new)
    end

    it '创建新项目' do
      expect {
        post :create, team_id: @team.id, name: '新项目'
      }.to change{Project.count}.by(1)

      project = Project.last
      expect(project.team).to eq(@team)

      expect(@user.projects).to include(project)
      expect(project.users).to include(@user)
    end
  end
end
