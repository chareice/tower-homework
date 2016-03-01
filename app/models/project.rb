class Project < ActiveRecord::Base
  belongs_to :team
  has_many :todos
  has_many :users, through: :accesses
  has_many :accesses
end
