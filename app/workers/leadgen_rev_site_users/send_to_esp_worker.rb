module LeadgenRevSiteUsers
  class SendToEspWorker
    include Sidekiq::Worker
    include Concerns::EspWorker

    def perform
      rules.each do |rule|
        leadgen_rev_site_users = available_leadgen_rev_site_users_for(rule)
        leadgen_rev_site_users = leadgen_rev_site_users.where('users.email ~* ?', '@' + rule.domain + '\.\w+$') if rule.domain.present?
        leadgen_rev_site_users.each_slice(rule.esp_rules_lists.count) do |slice|
          slice.each_with_index do |leadgen_rev_site_user, index|
            next unless rule.should_send_now?(leadgen_rev_site_user.created_at)
            params = { affiliate: leadgen_rev_site_user.affiliate }.compact
            esp_list = rule.esp_rules_lists[index]
            subscription_service_for(esp_list.list_type).new(esp_list.list, params: params, esp_rule: rule).send(ESP_METHOD_MAPPING[esp_list.list_type], leadgen_rev_site_user.user)
          end
        end
      end
    end

    private

    def rules
      EspRules::LeadgenRevSite.includes(source: :leadgen_rev_site_users).where.not(delay_in_hours: 0)
    end

    def available_leadgen_rev_site_users_for(rule)
      rule.leadgen_rev_site.leadgen_rev_site_users.is_verified
        .where('leadgen_rev_site_users.created_at >= ?', rule.delay_in_hours.hours.ago.beginning_of_hour).distinct
    end
  end
end
