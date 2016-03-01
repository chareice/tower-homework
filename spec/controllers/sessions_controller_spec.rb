require 'rails_helper'
include SessionsHelper

RSpec.describe SessionsController, type: :controller do
  before do
    @user = create(:user)
  end

  it '用户可以访问登录界面' do
    get :new
    expect(response).to render_template(:new)
  end

  it '用户可以登录' do
    email = @user.email
    password = '123456'
    expect(current_user).to be_nil
    post :create, email: email, password: password
    expect(current_user).to eq(@user)
  end

end
