class Comment < ActiveRecord::Base
  belongs_to :todo
  belongs_to :user

  after_create :send_create_event

  def send_create_event
    actor_name = self.user.username
    actor_id = self.user.id
    options = {
      action: 'comment_create',
      todo: self.todo,
      actor_name: actor_name,
      actor_id: actor_id,
      meta_data: {
        content: self.content
      }
    }
    Event.build(options)
  end
end
