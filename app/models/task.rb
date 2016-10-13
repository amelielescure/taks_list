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

  scope :postpone_date_current, -> { where('postpone_date <= ?', DateTime.now) }

  def task_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.find_or_create_by(name: name.strip)
    end
  end

  def task_tags
    tags.map(&:name).join(", ")
  end

  def self.filter_by_tag(name)
    postpone_date_current.joins(:tags).where('tags.name' => name)
  end
end
