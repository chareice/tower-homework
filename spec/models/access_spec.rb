require 'rails_helper'

RSpec.describe Access, type: :model do

  it '在用户创建project时会自动添加' do
    user = create(:user)
    expect{
      user.create_project('some_project_name')
    }.to change{Access.count}.by(1)
  end

end
