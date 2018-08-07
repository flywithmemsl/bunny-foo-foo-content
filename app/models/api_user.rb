class ApiUser < ApplicationRecord
  include Swagger::Blocks
  belongs_to :api_client

  swagger_schema :ApiUser do
    key :required, [:email, :first_name, :last_name]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :email do
      key :type, :string
    end
    property :first_name do
      key :type, :string
    end
    property :last_name do
      key :type, :string
    end
    property :website do
      key :type, :string
    end
    property :s1 do
      key :type, :string
    end
    property :s2 do
      key :type, :string
    end
    property :s3 do
      key :type, :string
    end
    property :s4 do
      key :type, :string
    end
    property :s5 do
      key :type, :string
    end
    property :is_verified do
      key :type, :boolean
    end
    property :is_useragent_valid do
      key :type, :boolean
    end
    property :is_impressionwise_test_success do
      key :type, :boolean
    end
    property :is_duplicate do
      key :type, :boolean
    end
  end

  swagger_schema :ApiUserInput do
    allOf do
      schema do
        key :required, [:email, :first_name, :last_name]
        property :email do
          key :type, :string
        end
        property :first_name do
          key :type, :string
        end
        property :last_name do
          key :type, :string
        end
        property :website do
          key :type, :string
        end
        property :s1 do
          key :type, :string
        end
        property :s2 do
          key :type, :string
        end
        property :s3 do
          key :type, :string
        end
        property :s4 do
          key :type, :string
        end
        property :s5 do
          key :type, :string
        end
      end
    end
  end
end