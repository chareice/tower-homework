require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  before do
    @user = create(:user)
    @project = create(:project)
    sign_in(@user)
  end

  describe '可以获取到某个项目的todo列表' do
    it '渲染index模版' do
      get :index, project_id: @project.id
      expect(response).to render_template(:index)
    end
  end

  describe '用户创建项目的todo' do
    it '可以访问新建todo页面' do
      get :new, project_id: @project.id
      expect(response).to render_template(:new)
    end

    it '用户未登录状态需要跳转到登录界面' do
      sign_out
      get :new, project_id: @project.id
      expect(response).to have_http_status(302)
    end
  end

end
