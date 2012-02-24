require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test "validations" do
    assert !Member.new(:last_name => "Last name", :voice => "Sopran").save, "Member without a first name was saved."
    assert !Member.new(:first_name => "First name", :voice => "Sopran").save, "Member without a last name was saved."
    assert !Member.new(:first_name => "First name", :last_name => "Last name").save, "Member without a vocal range was saved."
  end

  test "callbacks" do
    member = Member.create(:first_name => "Lorem", :last_name => "Ipsum", :voice => "sopran")
    assert_equal "S", member.voice
  end

  test "methods" do
    Member.create(:first_name => "First name", :last_name => "Last name", :voice => "S")
    Member.create(:first_name => "First name", :last_name => "Last name", :voice => "S")
    Member.create(:first_name => "First name", :last_name => "Last name", :voice => "A")
    Member.create(:first_name => "First name", :last_name => "Last name", :voice => "T")
    Member.by_voice("sopran").to_a.sort == Member.where(:voice => "S")
    assert_equal "Kenny McCormick", Member.new(:first_name => "Kenny", :last_name => "McCormick").to_s
  end
end
