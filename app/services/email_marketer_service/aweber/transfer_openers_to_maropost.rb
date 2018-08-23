module EmailMarketerService
  module Aweber
    class TransferOpenersToMaropost
      def initialize(aweber_list: nil, maropost_list: nil, since: nil)
        @aweber_list = aweber_list
        @maropost_list = maropost_list
        @since = since.is_a?(Date) ? since : Date.parse(since) rescue nil
      end

      def call
        FetchOpeners.new(list: @aweber_list, since: @since).call do |subscribers|
          create_leads(build_lead_list(subscribers))
        end
        EmailMarketerService::Converters::AweberToMaropost.new(maropost_list: @maropost_list).call
      end

      private

      def build_lead_list(subscribers)
        subscribers.each_with_object([]) do |subscriber, memo|
          next if should_skip_subscriber?(subscriber)
          memo << {
            email: subscriber.email,
            full_name: subscriber.name,
            details: {
              subscribed_at: subscriber.subscribed_at
            }
          }
        end
      end

      def create_leads(leads)
        return if leads.empty?
        Leads::AweberToMaropost.import(leads)
      rescue => e
        puts "Error during import: #{e.to_s}"
      end

      def should_skip_subscriber?(subscriber)
        existing_lead_emails.include?(subscriber.email) || (@since.present? && Date.parse(subscriber.subscribed_at) < @since)
      end

      def existing_lead_emails
        @existing_lead_emails ||= Leads::AweberToMaropost.pluck(:email)
      end
    end
  end
end
