FactoryBot.define do
  factory :result do
    user_id 1
    survey_id 1
    answers ['left', 'right', 'left']
    matches []
  end
end
