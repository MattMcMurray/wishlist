class SharedController < ApplicationController
  allow_unauthenticated_access
  before_action :set_list_share

  def shared
    raise ActionController::RoutingError.new("Not Found") if @list_share.nil? || @list_share.share_type != "public_link"
    authorize :shared

    @list = @list_share.list
    @wishlist_items = @list.wishlist_items

    if @list
      respond_to do |format|
        format.html { render :show, status: :ok }
      end
    end
  end

  private

  def set_list_share
    @list_share = ListShare.find(params[:share_token])
  end
end
