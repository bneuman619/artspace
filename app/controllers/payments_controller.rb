class PaymentsController < ApplicationController

  def new
    # Redirect the user to the authorize_uri endpoint
    url = Payment.get_url
    redirect_to url
  end

  def callback
    @stripe_response = params

    if params["error"]
      flash[:notice] = "Stripe authorization unsuccessful"
    else

      code = params[:code]
      # Make a request to the access_token_uri endpoint to get an access_token
      @response = Payment.get_authorization_tokens(code)

      current_user.payments.create(secret_api_key: @response.token,
                                  publishable_api_key: @response.params["stripe_publishable_key"],
                                  refresh_token: @response.refresh_token,
                                  stripe_user_id: @response.params["stripe_user_id"])

      space = User.find(current_user.id).spaces_created.last.id
      redirect_to space_path(space)

    end
  end

  def charge
    token = params["token_key"] # obtained with checkout.js
    amount = params["amount"]
    space = Space.find(params["reservation_data"]["space_id"])
    description = params["description"]

    Stripe.api_key = space.creator.secret_key

    response =  Stripe::Charge.create(
      :amount => amount,
      :currency => "usd",
      :card => token,
      :description => description
    )

    if response.paid
      resp = create_reservations(params["reservation_data"])
      resp["payment"] = response
      resp["totalCharge"] = resp["payment"]["amount"]

      render json: resp.to_json
    else
      render json: {status: 'error', error: 'problem with charge'}.to_json
    end
  end

  def pos
    @publishable_key = current_user.publishable_key #current_space.creator.publishable_key
    @email = current_user.email
  end
end


