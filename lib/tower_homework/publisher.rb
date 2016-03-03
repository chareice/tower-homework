module TowerHomework
  class Publisher
    def self.publish(exchange, message = {})
      if exchange == 'event'
        event = Event.new
        event.action = message[:action]
        #存储Event的Actor信息
        event.actor_name = message[:actor_name]
        event.actor_id = message[:actor_id]
        #存储Event的TargetTodo信息
        event.target_todo_content = message[:target_todo_content]
        event.target_todo_id = message[:target_todo_id]
        #存储Event的Project信息
        event.project_name = message[:project_name]
        event.project_id = message[:project_id]

        #存储变化信息
        event.from = message[:from] if message[:from]
        event. to = message[:to] if message[:to]
        
        event.meta_data = message[:meta_data] if message[:meta_data]
        event.save!
      end
    end
  end
end
