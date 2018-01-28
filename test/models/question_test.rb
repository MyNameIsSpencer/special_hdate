require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  def setup
    create(:survey, id:1)
  end


  test "option_a is present" do
    question = build(:question, option_a: nil, option_b: 'no more')
    question2 = build(:question, option_a: '', option_b: 'arebadarchi')
    question3 = build(:question)
    refute question.valid?
    refute question2.valid?
    assert question3.valid?
  end

  test "option_b is present" do

    question = build(:question, option_a: nil)
    question2 = build(:question, option_a: '')
    question3 = build(:question, option_a: 'hello', option_b: 'goodbye', survey_id: 1)
    refute question.valid?
    refute question2.valid?
    assert question3.valid?

  end

  test "option_a and option_b are different" do
    question = build(:question, option_a: "East", option_b: "North", survey_id: 1)
    question2 = build(:question, option_a: "West", option_b: "West", survey_id: 1)

    assert question.valid?
    refute question2.valid?
  end

  test 'options unique through both columns' do
    question_set1 = create(:question, option_a: "Test", option_b: "Best", survey_id: 1)
    question_set2 = create(:question, option_a: "Vest", option_b: "Mest", survey_id: 1)
    question = build(:question, option_a: "Best", option_b: "Test", survey_id: 1)
    question2 = build(:question, option_a: "Chest", option_b: "Vest", survey_id: 1)
    question3 = build(:question, option_a: "Vest", option_b: "Crest", survey_id: 1)
    question4 = build(:question, option_a: "West", option_b: "Mest", survey_id: 1)

    refute question.valid?
    refute question2.valid?
    refute question3.valid?
    refute question4.valid?

  end

end
