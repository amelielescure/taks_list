# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  task_id    :integer
#  tag_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

require "rails_helper"

RSpec.describe Tagging, :type => :model do
  it { is_expected.to belong_to :task }
  it { is_expected.to belong_to :tag }
end
