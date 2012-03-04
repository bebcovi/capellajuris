require "heroku_backup_task/tasks"
require "heroku"
require "aws/s3"
require "open-uri"

BACKUP_DAYS = {
  "monday"    =>  1,
  "wednesday" =>  3,
  "friday"    =>  5,
  "sunday"    =>  0
}

namespace :backup do
  task :daily do
    if BACKUP_DAYS.values.include?(Time.now.wday)
      Rake::Task["heroku_backup"].invoke
    end
  end

  task :monthly => :establish_s3_connection do
    make_backup = proc do
      pgbackups_client = PGBackups::Client.new(ENV["PGBACKUPS_URL"])
      latest_backup_url = pgbackups_client.get_latest_backup["public_url"]
      AWS::S3::S3Object.store("capellajuris_monthly_backup.dump", open(latest_backup_url), "database_backups1")
    end

    begin
      backup = AWS::S3::S3Object.find("capellajuris_monthly_backup.dump", "database_backups1")
      if Time.now.month == backup.last_modified.month + 1
        make_backup.call
      end
    rescue AWS::S3::NoSuchKey
      make_backup.call
    end
  end
end

task :establish_s3_connection do
  AWS::S3::Base.establish_connection! \
    :access_key_id => ENV["AMAZON_ACCESS_KEY_ID"],
    :secret_access_key => ENV["AMAZON_SECRET_ACCESS_KEY"]
end
