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
      # redirect_to "root"

    end
  end

end
