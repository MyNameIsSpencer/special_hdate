require 'test_helper'

class FsaTest < ActiveSupport::TestCase
  test "name must be present" do
    fsa = build(:fsa, name: nil)
    fsa2 = build(:fsa)
    refute fsa.valid?
    assert fsa2.valid?
  end

  test "FSA length is 3" do
    fsa1=build(:fsa, name: 'AA')
    fsa2=build(:fsa, name: 'AAA')
    fsa3=build(:fsa, name: 'AAAA')
    refute fsa1.valid?
    assert fsa2.valid?
    refute fsa3.valid?
  end

end
