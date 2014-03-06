class PaymentsController < ApplicationController

  def new
    url = Payment.get_url
    redirect_to url
  end

  def callback
    @stripe_response = params

    if params["error"]
      flash[:notice] = "Stripe authorization unsuccessful"
    else

      code = params[:code]
      @response = Payment.get_authorization_tokens(code)

      current_user.payments.create(secret_api_key: @response.token,
                                  publishable_api_key: @response.params["stripe_publishable_key"],
                                  refresh_token: @response.refresh_token,
                                  stripe_user_id: @response.params["stripe_user_id"])

      space = User.find(current_user.id).spaces_created.last.id
      redirect_to space_path(space)

    end
  end

end


