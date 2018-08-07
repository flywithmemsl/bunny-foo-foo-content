ActiveAdmin.register FormsiteUserAnswer do

  index do
    selectable_column
    id_column
    column :answer_id
    column :question_id
    column "Formsite" do |answer|
      link_to answer.formsite.name, admin_formsite_path(answer.formsite)
    end
    column "Formsite User" do |answer|
      link_to answer.formsite_user.user.email, admin_formsite_user_path(answer.formsite_user)
    end
    actions
  end
end