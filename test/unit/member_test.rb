require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test "member validations" do
    assert !Member.new.save, "Member with blank first and last name was saved."
  end

  test "member callbacks" do
    member = Member.create(:first_name => "Lorem", :last_name => "Ipsum", :voice => "sopran")
    assert_equal "S", member.voice
  end
end
