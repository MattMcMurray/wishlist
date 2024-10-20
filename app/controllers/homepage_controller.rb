class HomepageController < ApplicationController
  allow_unauthenticated_access

  def index
    redirect_to lists_path if find_session_by_cookie.present?
  end
end
