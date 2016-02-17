require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  describe '获取team列表' do
    before do
      10.times {
        create(:team)
      }
    end

    it '渲染index模版' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe '新建team' do
    it '渲染new模版' do
      get :new
      expect(response).to render_template(:new)
    end

    it '创建新team' do
      params = {name: 'Apple Watch设计团队'}

      expect{
        post :create, @params
      }.to change{Team.count}.by(1)
      expect(response).to redirect_to(action: :index)
    end
  end
end
