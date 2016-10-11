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

  def task_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.find_or_create_by(name: name.strip)
    end
  end

  def task_tags
    self.tags.map(&:name).join(", ")
  end
end
