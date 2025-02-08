# ApiExceptions Folder
module ApiExceptions
  # Base Exception Class
  class BaseException < StandardError
    attr_reader :code, :message, :errors, :details, :type, :error_type

    def error_code_map
      {
        STANDARD_ERROR: { code: 1000, message: I18n.t('base_exceptions.standard_error') },
        RECORD_NOT_FOUND: { code: 1001, message: I18n.t('base_exceptions.record_not_found') },
        RECORD_NOT_UNIQUE: { code: 1002, message: I18n.t('base_exceptions.record_not_unique') },
        UNAUTHORIZED: { code: 1003, message: I18n.t('base_exceptions.unauthorized_user') },
        # custom exceptions
        INVALID_STATUS_CHANGE: { code: 2000, message: I18n.t('base_exceptions.invalid_status_change') },
        FAILED_REGISTRATION: { code: 2001, message: I18n.t('base_exceptions.failed_registration') },
        DUPLICATED_TEST: { code: 2002, message: I18n.t('base_exceptions.duplicated_test') },
        ACADEMY_ALREADY_CREATED: { code: 2003, message: I18n.t('base_exceptions.academy_already_created') },
        OPTIONS_FAILED: { code: 2004, message: I18n.t('base_exceptions.options_failed') },
        STUDENTS_NOT_CREATED: { code: 2005, message: I18n.t('base_exceptions.students_not_created') },
        REPEATED_QUESTION: { code: 2006, message: I18n.t('base_exceptions.repeated_question') }
      }
    end

    def initialize(error_type, errors, params)
      super()
      error = error_code_map[error_type]
      @error_type = error_type
      @details = [*errors]
      @code = error[:code] if error
      @message = parse_message(error[:message], params) if error
      @details = @details.flatten
      @type = 'Iswo'
    end

    def parse_message(message, params)
      @parsed_message = message.dup
      if params.present?
        params.each do |key, value|
          param = @parsed_message["{{#{parse_key(key)}}}"] || @parsed_message["%{#{parse_key(key)}}"]
          @parsed_message[param.to_s] = (value.to_s || 'nil') if param
        end
      end
      @parsed_message
    end

    def parse_key(key)
      if key.instance_of?(Integer)
        ''
      else
        key.try(:to_s)
      end
    end

    def get_code(error_type, code_base = 100)
      index = ERROR_CODES.find_index { |k, _| k == error_type }

      code_base + index
    end
  end
end
