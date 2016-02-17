require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '访问新注册用户页面' do
    it '渲染new模版' do
      get :new
      expect(response).to render_template(:new)
    end

    describe '注册新用户' do
      before do
        @params = {email: 'chareice@live.com', password: 'password'}
      end

      it '注册成功' do
        expect{
          post :create, @params
        }.to change{User.count}.by(1)
      end

      it '注册失败' do
        User.create!(@params)
        post :create, @params
        expect(assigns(:user).errors.any?).to be true
      end
    end

  end

end
