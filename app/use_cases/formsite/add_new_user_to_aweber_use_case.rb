class Formsite
  class AddNewUserToAweberUseCase < AddNewUserToEspUseCase
    def perform
      return false if !formsite_user.is_verified || user.blank?
      params = { affiliate: formsite_user.affiliate }.compact
      lists.each do |list|
        EmailMarketerService::Aweber::SubscriptionsService.new(list: list.aweber_list, params: params).add_subscriber(user)
      end
    end

    def list_class
      :formsite_aweber_lists
    end
  end
end
