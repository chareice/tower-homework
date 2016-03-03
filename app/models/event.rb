class Event < ActiveRecord::Base
  serialize :meta_data, JSON

  class << self
    def build(options={})
      todo = options[:todo]
      action = options[:action]
      meta_data = options[:meta_data] || nil
      from = options[:from] || nil
      to = options[:to] || nil
      actor_name = options[:actor_name] || todo.creator.username
      actor_id = options[:actor_id] || todo.creator.id
      TowerHomework::Publisher.publish('event', {
        action: action,
        actor_name: actor_name,
        actor_id: actor_id,
        target_todo_content: todo.content,
        target_todo_id: todo.id,
        project_id: todo.project.id,
        project_name: todo.project.name,
        from: from,
        to: to,
        meta_data: meta_data
      })
    end
  end
end
