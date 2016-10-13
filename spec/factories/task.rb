FactoryGirl.define do
  factory :task do
    title "First task"
    description "Description of my first task"
    postpone_date Time.now

    trait :with_tags do
      after(:create) do |task|
        task.tags << create(:tag, name: 'Tag 1')
        task.tags << create(:tag, name: 'Tag 2')
      end
    end
  end
end
