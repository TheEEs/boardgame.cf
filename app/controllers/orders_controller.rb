class OrdersController < ApplicationController
  before_action :authenticate_user!, except:[:show,:create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_orders, only: [:index,:update, :approve]
  include OrdersHelper
  # GET /orders
  # GET /orders.json
  def index
   
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if @order.approved 
      hmac_secret = Rails.application.credentials[:qr_verifier]
      token = JWT.encode({guid: @order.guid}, hmac_secret, 'HS256')
      qrcode = RQRCode::QRCode.new("#{Rails.configuration.host_name}/orders/#{token}")
      @qrcode = qrcode.as_png(size: 120*4).to_data_url
    end
  end

  #POST /orders/:id/approve
  def approve 
    @order = Order.find_by_guid!(params[:id])
    @order.update({approved: true})
    respond_to do |format|
      format.js{}
    end
  end

  def show_by_guid
    @order = Order.find_by_guid(guid)
    render "show"
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { 
          session[:order_id] = @order.id
          redirect_to @order, notice: 'Order was successfully created.' 
        }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { redirect_to game_path(@order.game_id), alert: "Cannot make your order" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      hmac_secret = Rails.application.credentials[:qr_verifier]
      decoded_token = JWT.decode params[:id], hmac_secret, true, { algorithm: 'HS256' }
      guid = decoded_token.first["guid"]
      @order = Order.find_by_guid!(guid) 
    rescue 
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :phone, :when, :game_id, :approved)
    end

    def set_orders 
      @pagy, @orders = pagy(current_user.orders.order(:created_at => :desc), items: 20)
    end

    def guid 
      params[:guid]
    end
end
