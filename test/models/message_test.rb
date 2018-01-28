require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  setup do
    user1 = create(:user, id: 2)
    user2 = create(:user, id: 4, email: 'test@test')
  end

  test 'user_id must be present' do
    message = build(:message, user_id: nil, receiver_id: 2)
    message2 = build(:message, user_id: 4, receiver_id: 2)
    refute message.valid?
    assert message2.valid?
  end

  test 'receiver_id must be present' do
    message = build(:message, user_id: 2, receiver_id: nil)
    refute message.valid?
  end


  test 'user cannot be reciever' do
    message1 = build(:message, user_id: 4, receiver_id: 2)
    message2 = build(:message, user_id: 2, receiver_id: 2)
    assert message1.valid?
    refute message2.valid?
  end

end
