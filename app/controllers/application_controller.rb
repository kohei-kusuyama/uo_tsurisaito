class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :admin_url
  before_action :authenticate_admin!, if: :admin_url

  def admin_url
  request.fullpath.include?("/admin")
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when Customer
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
