class ChargesController < ApplicationController
  def create
    #Create a strip customer object
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Payment.default_in_usd_cents,
      description: "Blocipedia premium subscription",
      currency: 'usd'
      )

      flash[:notice] = "Payment successfully processed. Thanks for upgrading to premium user."
      current_user.tier = "premium"
      if current_user.save
        flash[:notice] = 'current user sucessfully saved.'
        redirect_to user_path(current_user)
      else
        flash[:error] = 'There was a problem saving the user.'
        redirect_to new_charge_path
      end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def new
     @stripe_btn_data = {
       key: "#{ Rails.configuration.stripe[:publishable_key] }",
       description: "Blocipedia Premium",
       amount: Payment.default_in_usd_cents
      }    
  end
end

