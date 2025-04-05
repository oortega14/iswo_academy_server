module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authenticate_user!

      def index
        notifications = current_user.notifications.unread
        render json: notifications
      end

      def mark_as_read
        notification = current_user.notifications.find(params[:id])
        notification.update(status: :read)
        render json: { success: true }
      end
    end
  end
end
