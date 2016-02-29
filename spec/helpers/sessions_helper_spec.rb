require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  before do
    @user = create(:user)
  end

  it '可以设置current_user' do
    sign_in(@user)
    expect(current_user).to eq(@user)
  end

  it '可以清除用户登录信息' do
    sign_in(@user)
    expect(current_user).to eq(@user)
    sign_out
    expect(current_user).to be_nil
  end
end
