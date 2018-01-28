require 'test_helper'

class SurveyTest < ActiveSupport::TestCase

  test 'survey name is present' do
    survey = build(:survey, name: '')
    survey2 = build(:survey, name: nil)
    survey3 = build(:survey)
    refute survey.valid?
    refute survey2.valid?
    assert survey3.valid?
  end

  test 'survey name is unique' do
    survey = create(:survey)
    survey2 = build(:survey)
    survey3 = build(:survey, name: 'Hammer Time')
    refute survey2.valid?
    assert survey3.valid?
  end

end
