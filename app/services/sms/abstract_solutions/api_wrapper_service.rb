module Sms
  module AbstractSolutions
    class CaseSensitiveString < String
      def downcase
        self
      end

      def capitalize
        self
      end

      def to_s
        self
      end
    end

    class RequestError < StandardError; end

    class ApiWrapperService
      attr_reader :account

      API_PATH = 'https://app.abstractsolutions.net/exlapiservice/'
      API_V2_PATH = 'https://app.abstractsolutions.net/exlapi/'

      def initialize(account: nil)
        store_auth_session if session_empty?
        @account = account
      end

      def add_subscriber(params)
        invoke_as_authorized('member/addsubscriber', params, 'v2')
      end

      def simulate_mo(params)
        invoke_as_authorized('sms/mo', params)
      end

      def get_keywords(params)
        invoke_as_authorized('/campaign/keywords', params)
      end

      def update_subscriber(params)
        invoke_as_authorized('member/updatesubscriber', params, 'v2')
      end

      def login(username, password)
        response = HTTParty.post("#{API_PATH}users/login", body: { username: username, password: password }, headers: auth_headers)
        body = JSON.parse(response.body)
        if body['status'] == 'success'
          body['data']
        else
          raise RequestError, response['message']
        end
      end

      def lookup_provider(params)
        response = invoke_as_authorized('member/networklookup', params)
        if response['status'] == 'success'
          response['data']['id']
        end
      end

      def session_params
        if session_empty?
          store_auth_session
        end
        {
          user_key: fetch('abstractsolutions_user_key'),
          client_id: fetch('abstractsolutions_client_id')
        }
      end

      private

      def auth_headers(content_type = 'x-www-form-urlencoded')
        {
          CaseSensitiveString.new("apikey") => api_key,
          "Content-Type" => "application/#{content_type}"
        }
      end

      def store_auth_session
        data = login(username, password)
        Rails.cache.write('abstractsolutions_user_key', data['user_key'])
        Rails.cache.write('abstractsolutions_client_id', data['client_id'])
      end

      def session_empty?
        fetch('abstractsolutions_client_id').blank? || fetch('abstractsolutions_user_key').blank?
      end

      def api_key
        account&.api_key || ENV['ABSTRACTSOLUTIONS_API_KEY']
      end

      def username
        account&.username || ENV['ABSTRACTSOLUTIONS_USERNAME']
      end

      def password
        account&.password || ENV['ABSTRACTSOLUTIONS_PASSWORD']
      end

      def invoke_as_authorized(path, params, endpoint = 'service')
        method = endpoint == 'service' ? :perform_service_api_call : :perform_api_call
        response = self.send(method, path, params)
        if response['error'] == 'The user key is invalid'
          store_auth_session
          response = self.send(method, path, params)
        end
        raise RequestError, response['error'] if response['status'] == 'failure'
        response
      end

      def perform_service_api_call(path, params)
        response = HTTParty.post("#{API_PATH}#{path}", body: params.merge(session_params), headers: auth_headers)
        raise RequestError, response.to_s unless response.success?
        JSON.parse(response.body)
      end

      def perform_api_call(path, params)
        response = HTTParty.post("#{API_V2_PATH}#{path}", body: {
          data: params.merge(user_key: session_params[:user_key], user_id: session_params[:client_id])
        }.to_json, headers: auth_headers('json'))
        raise RequestError, response.to_s unless response.success?
        JSON.parse(response.body)
      end

      def fetch(key)
        Rails.cache.read(key)
      end
    end
  end
end
