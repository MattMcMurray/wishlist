class WishlistItemsController < ApplicationController
  before_action :get_list
  before_action :set_wishlist_item, only: %i[ show edit update destroy ]

  # GET /wishlist_items or /wishlist_items.json
  def index
    @wishlist_items = policy_scope(@list.wishlist_items.order(created_at: :desc))
  end

  # GET /wishlist_items/1 or /wishlist_items/1.json
  def show
    authorize @wishlist_item
  end

  # GET /wishlist_items/new
  def new
    authorize WishlistItem

    @wishlist_item = @list.wishlist_items.build
  end

  # GET /wishlist_items/1/edit
  def edit
    authorize @wishlist_item
  end

  # POST /wishlist_items or /wishlist_items.json
  def create
    authorize WishlistItem

    begin
      preview = LinkThumbnailer.generate(wishlist_item_params[:url])
      @wishlist_item = @list.wishlist_items.build(url: wishlist_item_params[:url], title: preview.title, description: preview.description)
    rescue LinkThumbnailer::Exceptions => e
      Sentry.capture_exception(e)
      @wishlist_item = @list.wishlist_items.build(url: wishlist_item_params[:url], title: wishlist_item_params[:url])
    end

    respond_to do |format|
      if @wishlist_item.save
        format.html { redirect_to list_wishlist_items_path, notice: "Wishlist item was successfully created." }
        format.json { render :show, status: :created, location: @wishlist_item }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wishlist_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wishlist_items/1 or /wishlist_items/1.json
  def update
    authorize @wishlist_item

    respond_to do |format|
      if @wishlist_item.update(wishlist_item_params)
        format.html { redirect_to list_wishlist_items_path(@list), notice: "Wishlist item was successfully updated." }
        format.json { render :show, status: :ok, location: @wishlist_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wishlist_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wishlist_items/1 or /wishlist_items/1.json
  def destroy
    authorize @wishlist_item
    @wishlist_item.destroy!

    respond_to do |format|
      format.html { redirect_to list_wishlist_items_path(@list), status: :see_other, notice: "Wishlist item was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wishlist_item
      @wishlist_item = @list.wishlist_items.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def wishlist_item_params
      params.expect(wishlist_item: [ :url, :title, :description ])
    end

    def get_list
      @list = List.find(params[:list_id])
    end
end
