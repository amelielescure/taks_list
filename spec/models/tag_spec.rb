# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

require "rails_helper"

RSpec.describe Tag, :type => :model do
  it { is_expected.to have_many :taggings }
  it { is_expected.to have_many :tasks }
end
