Quickbase::Connection.username = Settings.quickbase[:username]
Quickbase::Connection.password = Settings.quickbase[:password]
Quickbase::Connection.org = Settings.quickbase[:org]

ROUND_IDS = [1]

CONFIRMED_OFFER_STATUSES = [
    'Signed',
    'Transitioned'
]

# require 'quickbase/round'


# $quickbase = Quickbase::Connection.new(:apptoken => "35jbszc5wgw7hbifkyzudmnejpt", :dbid => 'bjimk9x68')

# $map_fields_number_to_name = {
#     "1" => :created_at,
#     "2" => :updated_at,
#     "3" => :id,
#     "6" => :vendor_name,
#     "7" => :category,
#     "8" => :sub_category,
#     "9" => :offer_status,
#     "10" => :partner_marketing_email,
#     "11" => :partner_marketing_contacts,
#     "12" => :pa_gcam,
#     "13" => :ccam,
#     "14" => :samsclub_com,
#     "15" => :total_clubs_selected,
#     "16" => :date_selected,
#     "17" => :product_name,
#     "18" => :sams_offer_details,
#     "19" => :product_upc,
#     "20" => :pallet_upc,
#     "21" => :sc_item,
#     "22" => :total_margin,
#     "23" => :sams_sell_price,
#     "24" => :offer_price,
#     "25" => :cost_to_income,
#     "26" => :total_margin
# }
#
# def quickbase
#
#   start_time = Time.now
#   data = $quickbase.api.do_query(
#       query: '',
#       clist: $map_fields_number_to_name.keys.join('.'),
#       friendly: $map_fields_number_to_name.values.map(&:to_s).join('.')
#   )
#
#   # quickbase.api.edit_record(data.first[:id], {:total_margin => "Washington"})
#
#   end_time = Time.now
#
#   return "QUICKBASE GET: #{data.size} Time duration: #{end_time - start_time}"
# end

module Quickbase
  class API
    def get_user_info(params = {})
      params[:fmt] = 'structured' if params[:fmt].nil? or params[:fmt].empty?
      response = connection.http.post("API_UserRoles", Quickbase::Helper.hash_to_xml(params))
      (Hash.from_xml response.xpath("//users").to_xml)['users']['user'] rescue {}
    end

    # Documentation at http://www.quickbase.com/api-guide/edit_record.html
    def upload_file(rid, field_name, content, file_name)
      field_name =
          if field_name =~ /^[-+]?[0-9]+$/
            'fid="'+ field_name.to_s+'" filename="'+ file_name+'"'
          else
            'name="'+field_name.to_s+'" filename="'+ file_name+'"'
          end

      fields = ["<field #{field_name}>#{Base64.strict_encode64(content)}</field>"]
      fields << Quickbase::Helper.hash_to_xml({rid: rid.to_s})

      connection.http.post('API_EditRecord', fields)
    end

    # Documentation at http://www.quickbase.com/api-guide/add_record.html
    def add_record_returning_rid(fields)
      response = add_record(fields)
      response = response.xpath("//objects[@type='array']/object/qdbapi")

      return nil unless response
      code = (response.xpath("//errcode")[0].children[0].text.to_i rescue 200)

      return nil unless code.zero?

      response.xpath("//rid")[0].children[0].text.to_i
    end
  end

  def execute_query(reference, query = '')
    t = Time.now
    quickbase = Quickbase::Connection.new(
        apptoken: Settings.quickbase.apptoken,
        dbid: Settings.quickbase.referrences[reference]['db']
    )

    Rails.logger.debug "------------------------------------------------"
    Rails.logger.debug "Referrence: #{reference}"
    Rails.logger.debug "DB: #{Settings.quickbase.referrences[reference]['db']}"
    Rails.logger.debug "Query: #{query}"
    Rails.logger.debug "Columns IDs: #{(Settings.quickbase.referrences[reference]['fields'].invert.keys).join('.')}"
    Rails.logger.debug "Columns: #{(Settings.quickbase.referrences[reference]['fields'].invert.values).join('.')}"

    result = quickbase.api.do_query(
        query: query,
        clist: Settings.quickbase.referrences[reference]['fields'].invert.keys.join('.'),
        friendly: Settings.quickbase.referrences[reference]['fields'].invert.values.join('.')
    )

    Rails.logger.debug "------------------------------------------------"
    Rails.logger.debug "Duration: #{Time.now - t} seconds"
    Rails.logger.debug "Count: #{result.count}"
    Rails.logger.debug "------------------------------------------------"

    result
  end
end

