class Formsite
  class AddNewUserToEliteUseCase < AddNewUserToEspUseCase
    def perform
      super do |mapping, user, params|
        EmailMarketerService::Elite::SubscriptionService.new(mapping.elite_group, params: params).add_contact(user)
      end
    end

    def mapping_association
      :formsite_elite_groups
    end
  end
end
