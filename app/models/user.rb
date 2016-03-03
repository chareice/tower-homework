class User < ActiveRecord::Base
  include AuthAble
  validates :email, :uniqueness => true
  validates :username, :uniqueness => true, presence: true
  has_many :projects, through: :accesses
  has_many :accesses

  #有执行的任务
  has_many :jobs, class_name: 'Todo', foreign_key: 'executor_id'

  def create_project(project_name, team)
    project = self.projects.build(name: project_name, team: team)
    res = self.save
    [project, res]
  end
end
