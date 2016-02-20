class User < ActiveRecord::Base
  include AuthAble
  validates :email, :uniqueness => true

  #有执行的任务
  has_many :jobs, class_name: 'Todo', foreign_key: 'executor_id'
end
