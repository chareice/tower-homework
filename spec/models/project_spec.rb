require 'rails_helper'

RSpec.describe Project, type: :model do
  it '可以创建' do
    expect{
      project = Project.new(name: '设计')
      project.save
    }.to change{Project.count}.by(1)
  end

  it '与team有关联' do
    team = create(:team)
    expect(team.projects).to be_empty

    project = create(:project)
    team.projects << project

    expect(team.projects).to include(project)
  end
end
