module Statistics
  module Questions
    class BaseStatistics < Statistics::BaseStatistic
      DEFAULT_CHART_RESPONSE = {
        categories: [],
        series: []
      }
  
      def total_chart_statistics(hash)
        hash[:categories] = categories
        hash[:series] = series 
        return hash
      end
  
      def categories
        filtered_questions.map do |question|
          {
            name: question_identification(question),
            categories: type_fields
          }
        end
      end
  
      def series 
        answers_hash = {}
        filtered_questions.each do |question|
          answers = question.answers
          type_fields.each do |field|
            answers_hash = fill_answers_hash(answers_hash, field, question, answers)
          end
        end
        return answer_hash_to_flat_list(answers_hash)
      end
  
      def formsite
        return @formsite if !@formsite.blank?
        @formsite = 
          if !formsite_id.blank?
            Formsite.find_by_id(formsite_id)
          else
            formsites.first
          end
      end
  
      private 
      def filtered_questions
        return @filtered_questions if !@filtered_questions.blank?
        @filtered_questions = 
          if formsite_selected?
            questions.where(formsite_id: formsite.id)
          else
            questions
          end
      end
  
      def question_identification question
        question.position
      end
  
      def fill_answers_hash(answers_hash, field, question, answers)
        answers.each do |answer|
          answer_text = answer.text.downcase
          answers_hash[question_identification(question)] ||= default_answer_hash.deep_dup
          answers_hash[question_identification(question)][answer_text][field] = answers_count(answer, field)
        end
        return answers_hash
      end
  
      def filtered_formsite_user_answers answer
        if !start_date.blank? && !end_date.blank?
          answer.formsite_user_answers.select { |user_answer|
            user_answer.created_at >= start_date && user_answer.created_at <= end_date
          }
        else
          answer.formsite_user_answers
        end
      end
  
      def answer_hash_to_flat_list hash
        response = answer_texts_hash
        hash.each do |question_id, question_answer_hash|
          question_answer_hash.each do |answer_text, s_counter_hash|
            response[answer_text].concat s_counter_hash.map {|key, value| value}
          end
        end
        response.map {|key, value| {name: key, data: value}}
      end
  
      def default_answer_hash
        return @default_answer_hash if !@default_answer_hash.blank?
        response = answer_texts_hash.deep_dup
        response.each do |key, value| 
          response[key] = type_fields_hash
        end
        return response
      end
  
      def answer_texts_hash
        return @answer_texts_hash if !@answer_texts_hash.blank?
        texts = filtered_answers
                  .sort!{ |a, b|  a.id <=> b.id } 
                  .pluck(:text).uniq
                  .map {|text| text.downcase}
        return @answer_texts_hash = Hash[ texts.collect { |field| [field, []] } ]
      end

      def type_fields_hash
        return @s_fields_hash if !@s_fields_hash.blank?
        @s_fields_hash = Hash[ type_fields.collect { |field| [field, 0] } ]
      end
    end
  end
end