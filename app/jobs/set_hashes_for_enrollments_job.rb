class SetHashesForEnrollmentsJob < ActiveJob::Base
  include Quickbase

  queue_as :default

  def perform
    fields = Settings.quickbase.referrences['enrollments']['fields']
    quickbase = Quickbase::Connection.new(
        apptoken: Settings.quickbase.apptoken,
        dbid: Settings.quickbase.referrences['enrollments']['db']
    )
    url = Settings.quickbase.referrences['enrollments']['url']


    ROUND_IDS.each do |cycle|
      enrollments = execute_query('enrollments', prepare_filter_for_enrollments_without_url(cycle, 'enrollments'))
      enrollments[0..10].each do |enrollment|
        Rails.logger.debug "Update Enrollment ##{enrollment[:enrollment_id]}"
        quickbase.api.edit_record(enrollment[:enrollment_id], {fields['url_id'].to_s => url + SecureRandom.hex(16)})
      end
    end
  end
  
  private

  def prepare_filter_for_enrollments_without_url(cycle, reference)
    filters = []

    filters << "{'#{Settings.quickbase.referrences[reference]['fields']['cycle_id']}'.EX.'#{cycle}'}"
    filters << "{'#{Settings.quickbase.referrences[reference]['fields']['url_id']}'.EX.''}"
    filters << "{'#{Settings.quickbase.referrences[reference]['fields']['enrollment_id']}'.XEX.''}"

    quickbase_status_column_id = Settings.quickbase.referrences[reference]['fields']['offer_status']

    filters << CONFIRMED_OFFER_STATUSES.collect { |status| "{'#{quickbase_status_column_id}'.EX.'#{status}'}" }.join('OR')

    filters.collect { |filter| "(#{filter})" }.join('AND')
  end
end