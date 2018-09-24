# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
job_type :rake_verbose, "cd :path && :environment_variable=:environment :bundle_command rake :task :output"

every 1.day do
  rake "aweber:migrate_subscribers"
end

every 1.day do
  rake_verbose "aweber:transfer_to_maropost"
end

every 1.day do
  rake "suppression_lists:autoremove_from_esp"
end

every 2.days do
  rake "aweber:collect_statistics"
end

every 2.days do
  rake "maropost:collect_statistics"
end
