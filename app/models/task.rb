# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  visible_date :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Task < ActiveRecord::Base
	has_many :taggings, :dependent => :delete_all
  has_many :tags, through: :taggings

  validates :title, presence: true
end
