class Question < ApplicationRecord

  belongs_to :survey
  validates :option_a, :option_b, presence: true
  validates_uniqueness_of :option_a, :option_b
  validate  :a_not_b
  validate  :a_and_b_unique_throughout_columns

  def a_not_b
    if option_a == option_b
      errors.add(:options, 'Options must be different')
    end
  end

  def a_and_b_unique_throughout_columns
    option_as = Question.all.collect{|question| question.option_a}
    option_bs = Question.all.collect{|question| question.option_b}
    option_as << option_a
    option_bs << option_b
    if (option_as & option_bs).empty? == false
      errors.add(:options, 'Option already exists')
    end
  end

  def save_picture_if_none_in_database(left, right)
    if self.option_a_url == nil
      self.update(option_a_url: left)
    end
    if self.option_b_url == nil
      self.update(option_b_url: right)
    end
  end

end
