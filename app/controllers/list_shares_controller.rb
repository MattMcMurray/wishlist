class ListSharesController < ApplicationController
  before_action :set_list_share, only: %i[ show edit update destroy ]

  # GET /list_shares or /list_shares.json
  def index
    @list_shares = ListShare.all
  end

  # GET /list_shares/1 or /list_shares/1.json
  def show
  end

  # GET /list_shares/new
  def new
    @list_share = ListShare.new
  end

  # GET /list_shares/1/edit
  def edit
  end

  # POST /list_shares or /list_shares.json
  def create
    @list_share = ListShare.new(list_share_params)

    respond_to do |format|
      if @list_share.save
        format.html { redirect_to @list_share, notice: "List share was successfully created." }
        format.json { render :show, status: :created, location: @list_share }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list_share.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /list_shares/1 or /list_shares/1.json
  def update
    respond_to do |format|
      if @list_share.update(list_share_params)
        format.html { redirect_to @list_share, notice: "List share was successfully updated." }
        format.json { render :show, status: :ok, location: @list_share }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list_share.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_shares/1 or /list_shares/1.json
  def destroy
    @list_share.destroy!

    respond_to do |format|
      format.html { redirect_to list_shares_path, status: :see_other, notice: "List share was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list_share
      @list_share = ListShare.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def list_share_params
      params.expect(list_share: [ :user_id, :type, :list_id ])
    end
end
