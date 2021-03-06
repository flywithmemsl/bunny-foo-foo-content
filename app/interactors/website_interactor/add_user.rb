module WebsiteInteractor
  class AddUser
    include Interactor

    delegate :website, :params, :request, :user, :formsite_user, :to => :context

    def call
      create_user
      create_formsite_user
      context.api_response = {user: user, is_verified: formsite_user&.is_verified, formsite_user: formsite_user}
    end

    def rollback
    end

    private

    def user_ip
      if !params.dig(:user, :ip).blank?
        params.dig(:user, :ip)
      else
        request.env["REMOTE_ADDR"]
      end
    end

    def website_service
      @website_service ||= FormsiteService.new
    end

    def is_useragent_valid
      website_service.is_useragent_valid(request.user_agent)
    end

    def is_impressionwise_test_success
      return false if user.blank?
      website_service.is_impressionwise_test_success(user)
    end

    def is_email_duplicate
      return false if user.blank?
      !website.formsite_users.joins(:user).where("users.email = ?", user.email).blank?
    end

    def is_ip_duplicate?
      !website.formsite_users.where(ip: user_ip).blank?
    end

    def create_user
      return if params[:user][:email].blank?
      context.user = User.create_with(
        first_name: params[:user][:first_name],
        last_name: params[:user][:last_name],
      ).find_or_create_by(email: params[:user][:email])
    end

    def create_formsite_user
      byebug
      if !user.blank? && user.email == FormsiteUser::TEST_USER_EMAIL
        create_test_user()
      else
        handle_formsite_user_creation()
      end
    end

    def create_test_user
      attributes = formsite_user_params
        .merge(formsite_user_dynamic_params)
        .merge({
          is_verified: true,
          is_useragent_valid: true,
          is_impressionwise_test_success: true,
          is_duplicate: false,
          ip: user_ip,
          user_id: user.id,
        })
      context.formsite_user = website.formsite_users.create(attributes)
    end

    def handle_formsite_user_creation
      attributes = formsite_user_params
        .merge(formsite_user_dynamic_params)
        .merge({
          ip: user_ip,
        })

      if user.blank?
        if !is_ip_duplicate?
          attributes = attributes.merge({
            is_duplicate: is_ip_duplicate?,
          })
          context.formsite_user = website.formsite_users.create(attributes)
        else
          context.formsite_user = website.formsite_users.find_by(ip: user_ip, user_id: nil)
        end
      else
        formsite_user = website.formsite_users.find_by(ip: user_ip, user_id: nil)
        attributes = attributes.merge({user_id: user.id})
        if formsite_user && formsite_user.persisted?
          formsite_user.update(attributes.merge(is_duplicate: false, is_verified: is_useragent_valid && is_impressionwise_test_success))
          context.formsite_user = formsite_user
        else
          attributes = attributes.merge({
            is_duplicate: is_ip_duplicate?,
          })
          context.formsite_user = website.formsite_users.create(attributes)
        end
      end
    end

    def formsite_user_dynamic_params
      is_verified = is_useragent_valid && is_impressionwise_test_success && !is_ip_duplicate?
      is_verified = is_verified && !params[:user][:first_name].blank? && !params[:user][:last_name].blank?
      {
        is_verified: is_verified,
        is_useragent_valid: is_useragent_valid,
        is_impressionwise_test_success: is_impressionwise_test_success,
        is_duplicate: is_ip_duplicate?,
        is_email_duplicate: is_email_duplicate,
        affiliate: params[:user][:a],
        job_key: params[:user][:key]
      }
    end

    def formsite_user_params
      params.require(:user).permit(:user_id, :s1, :s2, :s3, :s4, :s5, :birthday, :phone, :zip, :site_type)
    end

    def job_formsite_user_params
      params.require(:user).permit(:external_link, :company, :abstract, :title, :data_key)
    end
  end
end
