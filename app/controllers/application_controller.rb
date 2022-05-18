require_relative 'concerns/authentication'

class Admin::ApplicationController < ApplicationController
  include Admin::Concerns::Authentication
  include Common
  layout 'admin/layouts/admin'
  # include Common

  # Manipular excessões com :log_exception_handler
  # rescue_from Exception, with: :log_exception_handler unless Rails.env.development?
  # self.exception_data = Proc.new { |controller| controller.current_user ? "#{controller.current_user.login} - #{controller.current_user.nome}" : "" } unless Rails.env.development?

  # Manipular excessões de permissões do CanCanCan
  rescue_from CanCan::AccessDenied do
    redirect_to admin_root_url, alert: t('views.responses.acess_denied')
  end
end
