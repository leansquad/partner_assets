class Enrollment
  include Quickbase

  def initialize(args)
    attributes = execute_query('enrollments', prepare_filter(args[:id], 'enrollments', 'uid'))[0]
    return unless attributes.present?

    @id = attributes[:id]
    @uid = args[:id]

    @offer_id = attributes[:offer_id]
    @offer = execute_query('offers', prepare_filter(@offer_id, 'offers'))[0]

    @partner_id = @offer[:partner_id]
    @partner = execute_query('partners', prepare_filter(@partner_id, 'partners'))[0]

    @round_id = attributes[:round_id]
    @round = execute_query('rounds', prepare_filter(@round_id, 'rounds'))[0]
  end

  attr_reader :id, :cycle_id, :partner_id, :partner, :offer, :offer_id, :uid, :round_id, :round, :total_clubs_mapped


  private

  def prepare_filter(id, reference, column = 'id')
    "{'#{Settings.quickbase.referrences[reference]['fields'][column]}'.EX.'#{id}'}"
  end
end