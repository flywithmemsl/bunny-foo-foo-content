ActiveAdmin.register_page "Questions Subaffiliate Table Statistics" do
  menu false

  controller do
    before_action :initialize_data, only: :index

    def initialize_data
      @questions_statistics = Statistics::Questions::SStatistics.new(params)
    end

    def index
      respond_to do |format|
        format.html
        format.csv { send_data @questions_statistics.stats_to_csv(affiliate: true), filename: "subaffiliate_#{Formsite.find_by(id: params[:formsite_id]).name}_#{params[:start_date]}_#{params[:end_date]}.csv" }
      end
    end
  end

  sidebar :help do
    render 'filters', stats_service: questions_statistics
  end

  content do
    render 'questions_table_stats', table_stats: questions_statistics.table_stats
  end
end
