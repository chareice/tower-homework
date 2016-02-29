require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before do
    @user = create(:user)
  end

  it '用户可以访问登录界面' do
    get :new
    expect(response).to render_template(:new)
  end

  it '用户可以登录' do
    username = @user.username
    password = '123456'

    post :create
    debugger
  end

end
