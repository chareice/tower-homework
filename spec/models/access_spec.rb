require 'rails_helper'

RSpec.describe Access, type: :model do

  it '在用户创建project时会自动添加' do
    user = create(:user)
    team = Team.new(name: 'Apple Watch设计团队')
    team.save
    expect{
      user.create_project('some_project_name', team)
    }.to change{Access.count}.by(1)
  end

end
