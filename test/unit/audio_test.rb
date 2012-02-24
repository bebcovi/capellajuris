require 'test_helper'
require 'aws/s3'
require 'unit/amazon/aws_s3_helper'

class AudioTest < ActiveSupport::TestCase
  def setup
    files_path = "#{Rails.root}/test/fixtures/files"
    @aac1 = File.open "#{files_path}/audio1.aac"
    @ogg1 = File.open "#{files_path}/audio1.ogg"
    @aac2 = File.open "#{files_path}/audio2.aac"
    @ogg2 = File.open "#{files_path}/audio2.ogg"
  end

  test "validations" do
    audio = Audio.create!(:title => "Unique title", :aac => @aac1, :ogg => @ogg1)
    assert !Audio.new(:aac => @aac1, :ogg => @ogg1).save, "Audio without a title was saved."
    assert !Audio.new(:title => "Unique title", :aac => @aac2, :ogg => @ogg2).save, "Audio with a title that's not unique was saved."
    assert !Audio.new(:title => "Title").save, "Audio without files was saved."
    assert !Audio.new(:title => "Title", :aac => @ogg1, :ogg => @aac1).save, "Audio with wrong formats was saved."
    assert !Audio.new(:title => "Title", :aac => @aac1, :ogg => @ogg1).save, "Audio with filenames that are not unique was saved."
    audio.destroy
  end

  test "creating and destroying" do
    audio = Audio.new(:title => "Hometown Glory", :aac => @aac1, :ogg => @ogg1)
    assert_difference("Audio.count") { audio.save }
    assert_nothing_raised(AWS::S3::NoSuchKey) { AmazonAudio.find(@aac1, @ogg1) }
    audio.destroy
    assert_raise(AWS::S3::NoSuchKey) { AmazonAudio.find(@aac1, @ogg1) }
  end

  test "methods" do
    audio = Audio.create!(:title => "Title", :aac => @aac1, :ogg => @ogg1)
    assert_equal audio.filenames, ["audio1.aac", "audio1.ogg"]
    assert_equal audio.files, ["aac", "ogg"].collect { |ext| "https://audio11.s3.amazonaws.com/audio1.#{ext}" }
    audio.destroy
  end
end
