class Message < ApplicationRecord

  # validates :user_id, :receiver_id, presence: true;

  belongs_to :sender, :class_name=>'User', :foreign_key=>'user_id'
  belongs_to :receiver, :class_name=>'User', :foreign_key=>'receiver_id'
  validate :sender_diff_receiver

  def sender_diff_receiver
    errors.add(:users, 'Sender cannot be receiver') if self.user_id ==self.receiver_id
  end

end
