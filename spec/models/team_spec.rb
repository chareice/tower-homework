require 'rails_helper'

RSpec.describe Team, type: :model do
  it '可以创建' do
    expect{
      team = Team.new(name: 'Apple Watch设计团队')
      team.save
    }.to change{Team.count}.by(1)
  end
end
