class User < ActiveRecord::Base
  include AuthAble
  validates :email, :uniqueness => true
end
