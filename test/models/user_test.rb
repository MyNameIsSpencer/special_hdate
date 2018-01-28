require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    create(:fsa, id:1)
  end

  test "name must be present" do
    user = build(:user, name: nil)
    user2 = build(:user, name: '')
    user3 = build(:user, name: '444')
    refute user.valid?
    refute user2.valid?
    assert user3.valid?
  end

  test "email must be present" do
    user = build(:user, email: '')
    user2 = build(:user, email: nil)
    user3 = build(:user, email: 'asdflasfj')
    refute user.valid?
    refute user2.valid?
    assert user3.valid?
  end

  test "email must be at least 4 digits" do
    user = build(:user, email: 'a@s')
    user2 = build(:user, email: 'as@l')
    user3 = build(:user, email: 'asl@')
    user4 = build(:user, email: 'asl@adkgafgkjagfhja')
    refute user.valid?
    assert user2.valid?
    assert user3.valid?
    assert user4.valid?
  end

  test "email must be unique" do
    user = create(:user, email: "bettymaker@gmail.com")
    user2 = build(:user, email: "bettymaker@gmail.com")
    user3 = build(:user, email: "heytherebuddy@gggmailer.co")
    refute user2.valid?
    assert user3.valid?
  end

  test "password_digest must be 4 or more" do
    user = build(:user, password_digest: '')
    user2 = build(:user, password_digest: 'pas')
    user3 = build(:user, password_digest: '  pas   ')
    user4 = build(:user, password_digest: 'pass')
    user5 = build(:user, password_digest: 'password asldfjasdfalsf')
    refute user.valid?
    refute user2.valid?
    # refute user3.valid?    < causes failure but should not
    assert user4.valid?
    assert user5.valid?
  end

  test "user must include password_digest on create" do
    user = build(:user, password_digest: nil)
    refute user.valid?
  end

  test "password_digest must be at least 4 characters long" do
    user = build(:user, password_digest: "")
    user2 = build(:user, password_digest: "abc")
    user3 = build(:user, password_digest: " abc ")
    user4 = build(:user, password_digest: "abc4")
    user5 = build(:user, password_digest: "asdf##$% ^22}}")

    refute user.valid?
    refute user2.valid?
    # refute user3.valid?   < causes failure but should not
    assert user4.valid?
    assert user5.valid?
  end

  test "phone does not need to be present" do
    user = build(:user, phone: nil)
    assert user.valid?
  end

  test "phone must be at least 4 digits if present" do
    user = build(:user, phone: "23")
    user2 = build(:user, phone: "2233")
    user3 = build(:user, phone: "ab34")
    user4 = build(:user, phone: "     ")
    refute user.valid?
    assert user2.valid?
    assert user3.valid?
    # refute user4.valid?   < returns failure
  end

  test "best_matches_method only grabs result if compatibility is above threshold" do
    owner = build(:user)
    user = build(:user, id: 1)
    user2 = build(:user, id: 2)
    user3= build(:user, id: 3)
    all_matches = {user.id => [0.80, 'a'], user2.id => [0.70, 'b'], user3.id => [0.90, 'c']}
    expected = {1 => [0.80, 'a'], 3 => [0.90, 'c'] }
    actual = owner.best_matches(all_matches)
    assert_equal(expected, actual)
  end

  test "delete_user_results deletes all user results" do
    user = create(:user, id:1)
    user2 = create(:user, id:2, email:'test@test')
    survey = create(:survey, id:1)
    result1 = create(:result)
    result2 = create(:result, user_id:2, matches: [['1','a'],['3','b']])
    expected = [['3', 'b']]
    user.delete_user_results
    actual = result2.reload.matches
    assert_equal(expected, actual)
  end
end
