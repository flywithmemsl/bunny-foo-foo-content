module Sms
  module AbstractSolutions
    class SubscriptionService
      SHORTDOMAIN_ID = 2.freeze

      attr_reader :params, :group, :cep_rule

      def initialize(params: {}, group: nil, cep_rule: nil)
        @group = group
        @cep_rule = cep_rule
        @params = params
      end

      def find_provider(cellphone)
        client.lookup_provider(cellphone: cellphone)
      rescue RequestError => e
        puts "AbstractSolutions lookup subscriber error - #{e}".red
      end

      def add(user, leadgen_rev_site = nil)
        return unless valid?(user, leadgen_rev_site)
        provider = find_provider(phone_number)
        return if provider.nil?
        mark_network_lookup_success(user, leadgen_rev_site)
        new_params = {
          subscriber_info:{
            email: user.try(:email),
            number: phone_number,
            carrier_id: provider,
            optinip: params[:ip],
            first_name: user&.first_name,
            last_name: user&.last_name,
            state: params[:state],
          }.compact,
          custom_info: {
            SourceURL: params[:url]
          },
          client_id: client.session_params[:client_id],
          tcpa: 1,
          shortdomain_id: SHORTDOMAIN_ID,
          groups: [
            {
              group_id: group&.group_id,
              tcpa: 1
            }
          ],
          urls: [
            {
              url: "https://www.mydomain.com/extra/sdfasdf45asdg4asd",
              tag: "slideshow_url"
            }
          ]
        }
        response = client.add_subscriber(new_params)
        
        mo_params = {
          cellnumber: phone_number,
          carrier_id: provider,
          shortcode_id: "55",
          message: group&.keyword
        }

        if response['status'] == 'success'
          id = response.dig('subscriber', 'id')
          mark_as_saved(user, leadgen_rev_site, id)
          client.simulate_mo(mo_params)
        end

        response
      rescue RequestError => e
        puts "AbstractSolutions adding subscriber error - #{e}".red
      end

      private

      def phone_number
        number = params[:phone]
        if number.length == 11
          number
        elsif number.length == 10
          "1#{number}"
        end
      end

      def client
        return @client if defined?(@client)
        @client = Sms::AbstractSolutions::ApiWrapperService.new(account: group&.account)
      end

      def valid?(user, leadgen_rev_site)
        if user.is_a?(ActiveRecord::Base)
          !SmsSubscriber.where(provider: 'AbstractSolutions', linkable: user, source: leadgen_rev_site).exists?
        else
          true
        end
      end

      def mark_as_saved(user, leadgen_rev_site, id)
        if user.is_a?(ActiveRecord::Base)
          SmsSubscriber
            .create_with(cep_rule_id: cep_rule&.id, group_id: group&.id, subscriber_id: id)
            .find_or_create_by(provider: 'AbstractSolutions', linkable: user, source: leadgen_rev_site)
        end
      end

      def mark_network_lookup_success(user, leadgen_rev_site)
        leadgen_rev_site_user = user&.leadgen_rev_site_users&.find_by(leadgen_rev_site_id: leadgen_rev_site&.id)
        return unless leadgen_rev_site_user
        leadgen_rev_site_user.update(network_lookup_success: true)
      end
    end
  end
end
