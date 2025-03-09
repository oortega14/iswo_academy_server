module Api
  module V1
    # Define Templates Controller
    class TemplatesController < BaseController
      # GET: '/api/templates/students_template'
      def students_template
        send_file Rails.root.join('public', 'templates', 'students-template.xlsx'),
                  filename: 'plantilla-estudiantes.xlsx',
                    type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      end
    end
  end
end
