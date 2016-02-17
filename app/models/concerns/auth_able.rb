module AuthAble
  module ClassMethods
    def auth(identity, password)
      user = self.find_by email: identity
      user ? user.auth(password) : false
    end
  end

  module InstanceMethods

    def auth(password)
      self.authenticate password
    end

    def as_json(options=nil)
      opts = {except: ["password_digest"]}
      super opts.merge(options)
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods

    # 可验证模型的配置
    receiver.has_secure_password validations: false
    receiver.validates :email, presence: true
  end
end
