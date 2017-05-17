class Hashtag < ActiveRecord::Base
  validates_presence_of :name, :company
  belongs_to :company
end
