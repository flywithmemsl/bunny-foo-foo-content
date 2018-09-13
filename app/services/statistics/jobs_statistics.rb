module Statistics
  class JobsStatistics < Statistics::BaseStatistic

    def job_counts_hash
      return @job_counts_hash if !@job_counts_hash.blank? 
      response = {}
      jobs.each do |job|
        response[job["external_id"]] = {
          job: job,
          total: total(job["external_id"]),
          submitted: submitted(job["external_id"]),
          total_converted: total_converted(job["external_id"]),
          failed_impressionwise: failed_impressionwise(job["external_id"]),
          failed_useragent: failed_useragent(job["external_id"]),
          failed_dulpicate: failed_dulpicate(job["external_id"])
        }
      end
      @job_counts_hash = response
      return @job_counts_hash
    end
  
    private

      def all_formsite_users
        @all_formsite_users ||= FormsiteUser.where.not(job_key: nil)
      end

      def total external_id
        users = users_grouped_by_job_key[external_id.to_s]
        return 0 if users.blank?
        users.count
      end

      def submitted external_id
        users = grouped_users_without_duplicates[external_id.to_s]
        return 0 if users.blank?
        users.select {|user| !user.user_id.blank?}.count
      end

      def total_converted external_id
        users = grouped_users_without_duplicates[external_id.to_s]
        return 0 if users.blank?
        users.select {|user| user.is_verified}.count
      end

      def failed_impressionwise external_id
        users = grouped_users_without_duplicates[external_id.to_s]
        return 0 if users.blank?
        users.select {|user| !user.is_impressionwise_test_success}.count
      end

      def failed_useragent external_id
        users = grouped_users_without_duplicates[external_id.to_s]
        return 0 if users.blank?
        users.select {|user| !user.is_useragent_valid}.count
      end

      def failed_dulpicate external_id
        users = users_grouped_by_job_key[external_id.to_s]
        return 0 if users.blank?
        users.select {|user| user.is_duplicate}.count
      end

      def grouped_users_without_duplicates
        @grouped_users_without_duplicates ||= all_formsite_users.select{|user| !user.is_duplicate}.group_by {|user| user["job_key"] }
      end

      def users_grouped_by_job_key
        @users_grouped_by_job_key ||= all_formsite_users.group_by {|user| user["job_key"] }
      end

      def jobs
        @jobs ||= JobsService.new().actual_links
      end
  end
end


