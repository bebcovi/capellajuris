## Running migrations

`$ bundle exec rake db:migrate`

`bundle exec` is put because we want to use Rake included in Bundle. You can add to your aliases:

- `$ alias migrate="bundle exec rake db:migrate"`
- `$ alias unmigrate="bundle exec rake db:migrate VERSION=0"`
