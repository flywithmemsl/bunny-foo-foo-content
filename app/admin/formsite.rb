ActiveAdmin.register Formsite do
  permit_params :name, :description, :url, :aweber_list_id, 
                :droplet_id, :droplet_ip, :zone_id,
                :repo_url, :first_redirect_url, :final_redirect_url,
                :favicon_image, :logo_image, :background,
                :is_thankyou, :is_checkboxes, :is_phone_number, :form_box_title_text,
                :left_side_content, :right_side_content,
                :first_question_code_snippet, :head_code_snippet,
                :s1_description, :s2_description, :s3_description, :s4_description, :s5_description, :affiliate_description, :ad_client,
                question_ids: [],
                questions_attributes: [
                    :id, :text, :flow, :position, :_update, :_create, :_destroy,
                    answer_ids: [],
                    answers_attributes: [:id, :text, :redirect_url, :question_id, :_create, :_destroy, :question
                  ]
                ],
                ad_ids: [],
                ads_attributes: [:id, :variety, :position, :widget, :google_id, :innerHTML, :_create, :_destroy],

                formsite_aweber_lists_attributes: [:id, :formsite_id, :aweber_list_id],
                formsite_maropost_lists_attributes: [:id, :formsite_id, :maropost_list_id],

                answer_ids: [],
                answers_attributes: [:id, :text, :redirect_url, :question_id, :_create, :_destroy, :question]
  

  filter :name
  filter :is_thankyou
  filter :is_checkboxes
  filter :is_phone_number
  filter :droplet_ip

  controller do
    before_action :initialize_data, only: :index

    def initialize_data
      @s_couter_use_case = Formsite::STotalCountersUseCase.new()
    end

    def scoped_collection
      super.includes :formsite_users
    end

  end

  index do
    column :id
    column :name
    column :is_thankyou
    column :is_checkboxes
    column :is_phone_number
    column :droplet_ip

    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :is_thankyou
      row :is_checkboxes
      row :is_phone_number
      row :favicon_image do |formsite|
        image_tag formsite.favicon_image.url unless formsite.favicon_image.url.nil?
      end
      row :logo_image do |formsite|
        image_tag formsite.logo_image.url unless formsite.logo_image.url.nil?
      end
      row :background do |formsite|
        image_tag formsite.background.url unless formsite.background.url.nil?
      end
      row :repo_url
      row :first_question_code_snippet
      row :head_code_snippet
      row :first_redirect_url
      row :final_redirect_url
      row :droplet_ip

      row :ad_client

      row :form_box_title_text
      row "Total users" do |formsite|
        link_to "#{formsite.formsite_users.count}", "/admin/formsite_users?utf8=✓&q%5Bformsite_id_eq%5D=#{formsite.id}&commit=Filter&order=id_desc"
      end
      row "Passed useragent users" do |formsite|
        link_to "#{formsite.formsite_users.where(is_useragent_valid: true).count}", "/admin/formsite_users?utf8=✓&q%5Bformsite_id_eq%5D=#{formsite.id}&q%5Bis_useragent_valid_eq%5D=true&commit=Filter&order=id_desc"
      end
      row "Passed impressionwise test users" do |formsite|
        link_to "#{formsite.formsite_users.where(is_impressionwise_test_success: true).count}", "/admin/formsite_users?utf8=✓&q%5Bformsite_id_eq%5D=#{formsite.id}&q%5Bis_impressionwise_test_success_eq%5D=true&commit=Filter&order=id_desc"
      end
      row "Duplicate users" do |formsite|
        link_to "#{formsite.formsite_users.where(is_duplicate: true).count}", "/admin/formsite_users?utf8=✓&q%5Bformsite_id_eq%5D=#{formsite.id}&q%5Bis_duplicate_eq%5D=true&commit=Filter&order=id_desc"
      end
      row :left_side_content, as: :wysihtml5, commands: 'all', blocks: 'all', height: 'huge'
      row :right_side_content, as: :wysihtml5, commands: 'all', blocks: 'all', height: 'huge'

      row :s1_description
      row :s2_description
      row :s3_description
      row :s4_description
      row :s5_description
      row :affiliate_description

      row "Aweber Lists" do |formsite|
        formsite.aweber_lists.map(&:full_name).join(",")
      end

      row 'Maropost Lists' do |formsite|
        formsite.maropost_lists.map(&:full_name).join(',')
      end

    end
    active_admin_comments
  end

  form do |f|
    TOOLBAR_BUTTONS = ['undo', 'redo', 'bold', 'italic', 'underline', 'color', 'insertLink','fontFamily', 'fontSize', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote']
    tabs do
      tab 'FORM SETTINGS' do
        f.object.repo_url = f.object.repo_url.blank? ? 'git@github.com:flywithmemsl/bff-forms.git' : f.object.repo_url
        f.inputs 'Formsite' do
          f.input :name
          f.input :is_thankyou
          f.input :is_checkboxes
          f.input :is_phone_number
          f.input :favicon_image
          f.input :logo_image
          f.input :background
          f.input :repo_url
          f.input :first_question_code_snippet
          f.input :head_code_snippet
          f.input :first_redirect_url
          f.input :final_redirect_url
          f.input :left_side_content, as: :froala_editor, input_html: f.object.decorate.admin_contet_wysiwyg_config
          f.input :right_side_content, as: :froala_editor, input_html: f.object.decorate.admin_contet_wysiwyg_config
          
          f.input :droplet_ip
          f.input :form_box_title_text

          f.input :ad_client

          f.input :s1_description
          f.input :s2_description
          f.input :s3_description
          f.input :s4_description
          f.input :s5_description
          f.input :affiliate_description

          f.inputs 'Aweber Lists' do
            f.has_many :formsite_aweber_lists, allow_destroy: true, new_record: true, heading: false do |ff|
              ff.semantic_errors
              ff.input :aweber_list, :label => 'List', :as => :select, :collection => AweberList.all
            end
          end

          f.inputs 'Maropost Lists' do
            f.has_many :formsite_maropost_lists, allow_destroy: true, new_record: true, heading: false do |ff|
              ff.semantic_errors
              ff.input :maropost_list, label: 'List', as: :select, collection: MaropostList.all
            end
          end
        end
        f.actions
      end
      tab 'QUESTIONS' do
        render "questions"
        f.actions
      end
      tab 'ADS AND TRACKER' do
        AD_POSITIONS = ['adSidebar', 'adTop', 'adMiddle', 'adBottom', 'adAppendedToBody', 'adpushup', 'tracker']
        AD_TYPES = ['embed', 'google', 'custom', 'text/javascript', 'autoad']

        f.inputs 'Ads' do
          f.has_many :ads, allow_destroy: true, new_record: true do |ff|
            ff.semantic_errors
            ff.input :position, :as => :select, :collection => AD_POSITIONS
            ff.input :variety, :as => :select, :collection => AD_TYPES
            ff.input :widget
            ff.input :google_id, :label => 'Google ID'
            ff.input :innerHTML
          end
        end
        f.actions
      end
    end

  end

  action_item :setup, :only => :show do
    link_to setup_api_v1_formsites_path(formsite), class: 'button builder_action', "data-type" => "json", remote: true do
      '<span>Setup Formsite</span> <span class="loader">
            <svg height="10px" viewBox="0 0 300 300" xmlns="http://www.w3.org/2000/svg" version="1.1">
              <path d="M 150,0 a 150,150 0 0,1 106.066,256.066 l -35.355,-35.355 a -100,-100 0 0,0 -70.711,-170.711 z" fill="#ffffff">
                <animateTransform attributeName="transform" attributeType="XML" type="rotate" from="0 150 150" to="360 150 150" begin="0s" dur=".5s" fill="freeze" repeatCount="indefinite"></animateTransform>
              </path>
            </svg>
        </span>'.html_safe
    end if formsite.droplet_ip.blank?
  end

  action_item :rebuild, :only => :show do
    link_to build_api_v1_formsites_path(formsite), class: 'button builder_action', "data-type" => "json", remote: true do
      '<span>Rebuild Formsite</span> <span class="loader">
            <svg height="10px" viewBox="0 0 300 300" xmlns="http://www.w3.org/2000/svg" version="1.1">
              <path d="M 150,0 a 150,150 0 0,1 106.066,256.066 l -35.355,-35.355 a -100,-100 0 0,0 -70.711,-170.711 z" fill="#ffffff">
                <animateTransform attributeName="transform" attributeType="XML" type="rotate" from="0 150 150" to="360 150 150" begin="0s" dur=".5s" fill="freeze" repeatCount="indefinite"></animateTransform>
              </path>
            </svg>
        </span>'.html_safe
    end if !formsite.droplet_ip.blank?
  end
end
