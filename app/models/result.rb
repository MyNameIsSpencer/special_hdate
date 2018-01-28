class Result < ApplicationRecord
  belongs_to :survey
  belongs_to :user

  def make_matches(best_matches)
    best_matches.each do |user_id, compatibility|
      combo = []
      combo[0] = "#{user_id}"
      combo[1] = "#{compatibility[0]}"
      combo[2] = "#{compatibility[1]}"
      if self.matches.include?(combo) == false
        self.matches << combo
        self.save
      end
    end
    return self.matches
  end

end
