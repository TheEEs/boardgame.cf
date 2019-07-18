module OrdersHelper
    def generate_encoded_url_for order
        hmac_secret = Rails.application.credentials[:qr_verifier]
        token = JWT.encode({guid: order.guid}, hmac_secret, 'HS256')
        link_to "Hiển thị", order_path(id: CGI.escape(token))
    end
end
