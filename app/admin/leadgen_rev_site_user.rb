ActiveAdmin.register LeadgenRevSiteUser do
  menu false

  permit_params :affiliate, :job_key,  :s1, :s2, :s3, :s4, :s5, :ndm_token, :birthday, :phone, :zip, :ip

  filter :created_at
  filter :leadgen_rev_site
  filter :is_verified
  filter :is_useragent_valid
  filter :is_impressionwise_test_success
  filter :is_duplicate

  filter :created_at, :as => :date_range

  filter :affiliate
  filter :affiliate_blank,   :as => :boolean

  filter :job_key

  filter :s1
  filter :s1_blank,   :as => :boolean

  filter :s2
  filter :s2_blank,   :as => :boolean

  filter :s3
  filter :s3_blank,   :as => :boolean

  filter :s4
  filter :s4_blank,   :as => :boolean

  filter :s5
  filter :s5_blank,   :as => :boolean


  index do
    column :id
    column :created_at
    column :leadgen_rev_site
    column :user
    column :is_verified
    column :is_useragent_valid
    column :is_impressionwise_test_success
    column :is_duplicate
    column :is_email_duplicate
    column :affiliate
    column :job_key
    column :s1
    column :s2
    column :s3
    column :s4
    column :s5
    column :ip
    column :ndm_token
    column :birthday
    column :phone
    column :zip
    column "First name" do |leadgen_rev_site_user|
      span leadgen_rev_site_user&.user&.first_name
    end
    column "Last name" do |leadgen_rev_site_user|
      span leadgen_rev_site_user&.user&.last_name
    end
    column :sent_to_aweber?
    column :sent_to_adopia?
    column :sent_to_elite?
    column :sent_to_ongage?
    actions
  end

  csv do
    column :created_at

    column "leadgen_rev_site" do |leadgen_rev_site_user|
      leadgen_rev_site_user&.leadgen_rev_site&.name
    end

    column "user_id" do |leadgen_rev_site_user|
      leadgen_rev_site_user.user_id
    end
    column :is_verified
    column :is_useragent_valid
    column :is_impressionwise_test_success
    column :is_duplicate
    column :affiliate
    column :job_key
    column :s1
    column :s2
    column :s3
    column :s4
    column :s5
    column :ndm_token
    column :ip
    column "First name" do |leadgen_rev_site_user|
      leadgen_rev_site_user&.user&.first_name
    end

    column "Last name" do |leadgen_rev_site_user|
      leadgen_rev_site_user&.user&.last_name
    end

    column "Email" do |leadgen_rev_site_user|
      leadgen_rev_site_user&.user&.email
    end
  end
end