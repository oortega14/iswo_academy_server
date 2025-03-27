# ApiExceptions Folder
module ApiExceptions
  # Base Exception Class
  class BaseException < StandardError
    attr_reader :code, :messages, :type, :error_type

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
        ALREADY_ADMIN_IN_OTHER_ACADEMY: { code: 2003, message: I18n.t('base_exceptions.already_admin_in_other_academy') },
        OPTIONS_FAILED: { code: 2004, message: I18n.t('base_exceptions.options_failed') },
        STUDENTS_NOT_CREATED: { code: 2005, message: I18n.t('base_exceptions.students_not_created') },
        REPEATED_QUESTION: { code: 2006, message: I18n.t('base_exceptions.repeated_question') },
        ALREADY_FIRST: { code: 2007, message: I18n.t('base_exceptions.already_first') },
        ALREADY_LAST: { code: 2008, message: I18n.t('base_exceptions.already_last') },
        USER_CANNOT_BE_ADMIN_AND_STUDENT_IN_SAME_ACADEMY: { code: 2009, message: I18n.t('base_exceptions.user_cannot_be_admin_and_student_in_same_academy') },
        CERTIFICATE_TEMPLATE_REQUIRED: { code: 2010, message: I18n.t('base_exceptions.certificate_template_required') },
        COURSE_ONLY_HAS_ONE_CERTIFICATE_CONFIGURATION: { code: 2011, message: I18n.t('base_exceptions.course_only_has_one_certificate_configuration') },
        NOT_VALID_FOR_PUBLISHING: { code: 2012, message: I18n.t('base_exceptions.not_valid_for_publishing') }
      }
    end

    def initialize(error_type, errors, params)
      super()
      error = error_code_map[error_type]
      @error_type = error_type
      @code = error[:code] if error
      error_messages = [*errors].flatten
      base_message = parse_message(error[:message], params) if error
      @messages = base_message ? [base_message] : []
      @messages += error_messages if error_messages.present?
      @messages = @messages.flatten.compact
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
