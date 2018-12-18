module EmailMarketerService
  module Mailgun
    class AutoRespond
      def initialize(list:, template:, lead:)
        @list = list
        @template = template
        @lead = lead
      end

      def call
        return unless email
        touch_lead if send_message
      end

      private

      def send_message
        params = {
          from: "#{@template.author} #{@template.author.parameterize.underscore}@#{domain}",
          to: email,
          subject: @template.subject,
          html: @template.body
        }
        response = client.post("/#{domain}/messages", params)
        body = JSON.parse(response.body)
        body.try(:fetch, 'id')
      rescue JSON::ParserError
        false
      end

      def client
        return @client if defined?(@client)
        @client = ::Mailgun::Client.new(@list.account.api_key)
      end

      def email
        @lead.linkable.try(:email)
      end

      def domain
        @list.address.split('@').second
      end

      def touch_lead
        @lead.autoresponded_at? ? @lead.touch(:followed_up_at) : @lead.touch(:autoresponded_at)
      end
    end
  end
end