class Formsite < ApplicationRecord
  has_many :formsite_questions
  has_many :questions, :through => :formsite_questions

  has_many :formsite_users
  has_many :users, :through => :formsite_users do
    def verified
      where("formsite_users.is_verified= ?", true)
    end

    def unverified
      where("formsite_users.is_verified= ?", false)
    end
  end

  accepts_nested_attributes_for :formsite_users, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :users, reject_if: :all_blank, allow_destroy: true

  accepts_nested_attributes_for :formsite_questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true

  def builder_config
    return {
        name: self.name,
        website_id: self.id,
        droplet_ip: self.droplet_ip,
        droplet_id: self.droplet_id,
        zone_id: self.zone_id,
        repo_url: 'git@github.com:flywithmemsl/bff-forms.git'
    }
  end
end