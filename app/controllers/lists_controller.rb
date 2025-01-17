class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]

  # GET /lists or /lists.json
  def index
    @lists = policy_scope(List)
  end

  # GET /lists/1 or /lists/1.json
  def show
    authorize @list
    respond_to do |format|
      format.html { redirect_to list_wishlist_items_path(@list) }
    end
  end

  # GET /lists/new
  def new
    authorize List

    @list = List.new
  end

  # GET /lists/1/edit
  def edit
    authorize @list
  end

  # POST /lists or /lists.json
  def create
    authorize List

    @list = List.new(**list_params, user_id: Current.user.id)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    authorize @list

    @list.destroy!

    respond_to do |format|
      format.html { redirect_to lists_path, status: :see_other, notice: "List was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.expect(list: [ :wishlist_items_id, :title, :description ])
    end
end
