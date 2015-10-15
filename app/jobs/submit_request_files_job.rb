class SubmitRequestFilesJob < ActiveJob::Base
  queue_as :default

  def perform(request_id)
    request = Request.find(request_id)
    request.submit_files_to_quickbase
  end
end
