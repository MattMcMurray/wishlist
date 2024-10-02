class HomepageController < ApplicationController
  allow_unauthenticated_access

  def index
    redirect_to "dashboard#index" if authenticated?
  end
end
