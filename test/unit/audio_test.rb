require 'test_helper'

class AudioTest < ActiveSupport::TestCase
  test "audios validations" do
    assert !Audio.new.save, "Audio without title or uploaded files was saved."
  end
end
