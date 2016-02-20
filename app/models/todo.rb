class Todo < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :executor, class_name: 'User', foreign_key: 'executor_id'

  belongs_to :project

  #分配任务执行者
  def assign_executor!(executor)
    self.executor = executor
    save!
  end

  #关闭任务
  def close!()
    self.state = 'closed'
    save!
  end

  #重新打开任务
  def reopen!()
    self.state = 'opened'
    save!
  end
end
