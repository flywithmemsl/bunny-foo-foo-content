module ApiUsers
  class SendToOngageWorker < SendToEspWorker
    def perform
      super do |params, mapping, api_user|
        EmailMarketerService::Ongage::SubscriptionsService
          .new(list: mapping.destination, params: params)
          .add_contact(api_user)
      end
    end

    private

    def mapping_class
      FormsiteMappings::Ongage
    end

    def list_to_user_association
      :api_client_ongage_lists
    end
  end
end
