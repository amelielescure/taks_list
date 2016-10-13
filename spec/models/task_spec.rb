require "rails_helper"

RSpec.describe Task, :type => :model do
  let!(:task) { FactoryGirl.create(:task, :with_tags) }

  it { is_expected.to have_many :taggings }
  it { is_expected.to have_many :tags }

  describe 'postpone_date_lower_date' do
    let!(:task1) { FactoryGirl.create(:task, :with_tags, postpone_date: DateTime.tomorrow) }
    it 'load all tasks with tags' do
      expect(described_class.postpone_date_lower_date).to eq [task]
    end
  end

  describe 'filter_by_tag' do
    it 'load all tasks filter by tag' do
      expect(described_class.filter_by_tag('Tag 1')).to eq [task]
    end
  end

  describe 'task_tags' do
    it { expect(task.task_tags).to eq 'Tag 1, Tag 2' }
  end
end
