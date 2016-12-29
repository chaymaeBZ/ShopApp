class ApiChargesController < BaseApiController

  before_action :validate_json, only: [:create]

  def create
    token = @json['token']
    begin
      charge = Stripe::Charge.create(
        :amount => 1000, # Amount in cents
        :currency => "usd",
        :source => token,
        :description => "Example charge"
      )

    rescue Stripe::CardError => e
      render nothing: true, status: :card_declined
    end
  end

  private
    def validate_json
      unless @json.has_key?('token')
        render nothing: true, status: :bad_request
      end
    end
end
