require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user_info = {username: 'chareice', email: 'chareice@live.com', password: '123456'}
    @user = User.create!(@user_info)
  end

  it '不能有重复的email' do
    expect {
      User.create!(@user_info)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it '可以验证email和密码' do
    expect(
      User.auth(@user_info[:email], @user_info[:password])
    ).to eq(@user)

    expect(
      User.auth('some@email.com', 'pass')
    ).to be false
  end

  it '可以创建项目' do
    team = Team.new(name: 'Apple Watch设计团队')
    team.save
    expect{
      @user.create_project('some_project_name', team)
    }.to change{Project.count}.by(1)
  end
end
