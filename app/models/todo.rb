class Todo < ActiveRecord::Base
  validates :content, presence: true

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :executor, class_name: 'User', foreign_key: 'executor_id'

  belongs_to :project
  has_many :comments

  after_create :send_create_event
  before_update :send_change_event
  after_destroy :send_destroy_event

  #进行中的任务
  scope :on_processing, ->{
    where(state: 'opened')
  }

  def update_attributes_by_user!(actor, params)
    @actor = actor
    self.update_attributes!(params)
  end

  def destroy_by(actor)
    @actor = actor
    self.destroy
  end

  #分配任务执行者
  def assign_executor!(executor)
    self.executor = executor
    save!
  end

  #关闭任务
  def close!(closer)
    unless self.state == 'opened'
      return
    end

    self.state = 'closed'
    save!
    send_close_todo_event(closer)
  end

  #重新打开任务
  def reopen!()
    self.state = 'opened'
    save!
  end

  private
  def send_create_event
    options = {action: 'todo_create', todo: self}
    if self.executor
      options[:meta_data] = {executor_name: executor.username}
    end
    Event.build(options)
  end

  def send_change_event
    changed = false
    #修改了任务的截止时间
    if self.deadline_changed?
      deadline_change = self.changes['deadline']
      from = deadline_change[0]
      to = deadline_change[1]
      action = 'change_deadline'
      changed = true
    end

    if self.executor_id_changed?
      executor_change = self.changes['executor_id']
      from_id = executor_change[0]
      to_id = executor_change[1]

      if from_id
        from = User.find(from_id).username
      else
        from = nil
      end

      to = User.find(to_id).username
      changed = true
      action = 'change_executor'
    end

    if changed
      options = {action: action, todo: self, from: from, to: to}
      if @actor
        options[:actor_name] = @actor.username
        options[:actor_id] = @actor.id
      end
      Event.build(options)
    end
  end

  def send_destroy_event
    options = {action: 'destroy_todo', todo: self}
    if @actor
      options[:actor_name] = @actor.username
      options[:actor_id] = @actor.id
    end
    Event.build(options)
  end

  def send_close_todo_event(closer)
    options = {action: 'close_todo', todo: self, actor_name: closer.username, actor_id: closer.id}
    Event.build(options)
  end
end
