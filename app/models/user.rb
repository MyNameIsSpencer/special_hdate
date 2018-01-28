class User < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#"}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :name, :email, :password_digest, presence: true
  validates :email, :password_digest, length: {minimum: 4}
  validates :email, uniqueness: true, on: :create
  validates :phone, length: {minimum: 4}, :allow_blank => true
  # validates :fsa_id, :allow_blank => true

  has_many :results, :dependent => :destroy

  has_many :sent_messages, :class_name=> 'Message', :foreign_key=>'user_id', :dependent=>:destroy
  has_many :recieved_messages, :class_name=> 'Message', :foreign_key=>'receiver_id', :dependent=>:destroy

  belongs_to :fsa, optional: true

  has_secure_password


  def match_generator(result)
    all_matches = Hash.new(0.00)
    @other_user_results = Array.new
    @results = Result.all
    @results.each do |other_result|
      if other_result.survey_id == result.survey_id && other_result.user_id != result.user_id
        @other_user_results << other_result
      end
    end
    @other_user_results.each do |survey_result|
      count = 0.00
      survey_result.answers.each_with_index do |each_answer, index|
        if each_answer == result.answers[index]
          count += 1
        end
      end
      compatibility = count /survey_result.answers.length
      all_matches[survey_result.user_id] = [compatibility, survey_result.created_at]
    end
    best = best_matches(all_matches)
    return best
  end

  def best_matches(all_matches)
    best_matches = {}
    all_matches.each do |user_id, compatibility|
    # compares match compatibility to the reference
      if compatibility[0] >= 0.75
        best_matches[user_id]=compatibility
      end
    end
    return best_matches
  end

  def user_matches
    user_matches =[]
    self.results.each do |result|
      match = User.find(self.match_generator(result).keys)
      user_matches << match
    end
    user_matches.flatten!
    return user_matches
  end

  def delete_user_results
    Result.all.each do |result|
      result.matches.map! do |match|
        if match[0].to_i == self.id
          result.matches.delete(match)
          result.save
          return result
        end
      end
    end
  end

end
