module FormsiteUsers
  class SendToAweberWorker
    include Sidekiq::Worker

    def perform
      formsite_users.each do |api_user|
        formsite_user.formsite_aweber_lists.each do |mapping|
          next unless mapping.should_send_now?(api_user.created_at)
          params = { affiliate: mapping.tag }.compact
          service_class.new(list: mapping.aweber_list, params: params).add_subscriber(api_user)
        end
      end
    end

    private

    def formsite_users
      FormsiteUser
        .joins(:formsite_aweber_lists)
        .includes(:formsite_aweber_lists, :aweber_lists)
        .left_joins(:aweber_list_users)
        .where(email_marketer_list_users: { id: nil })
        .where.not(formsite_aweber_lists: { delay_in_hours: 0 })
    end

    def service_class
      EmailMarketerService::Aweber::SubscriptionsService
    end
  end
end
