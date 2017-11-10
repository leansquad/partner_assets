set :output, 'log/cron.log'

# every 1.hour do
#   rake 'smartsheet:import'
# end

# every 20.minutes do
#   rake 'smartsheet:update_offers_rows'
# end
#
# every 1.day, at: '0:00 AM' do
#   rake 'quickbase:update_offers_rows'
# end
#
#
# every 30.minutes do
#   rake 'scheduler:clean_old_sessions'
# end
#
# every 5.minutes do
#   runner 'SetHashesForEnrollmentsJob.perform_later'
# end