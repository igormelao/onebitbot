class Hashtag < ActiveRecord::Base
  validates_presence_of :name, :company
  
  has_many :faq_hashtags
  has_many :faqs, through: :faq_hashtags
  belongs_to :company
end
