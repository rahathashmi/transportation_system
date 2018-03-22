class Api::SessionsController < Devise::SessionsController
  # skip_before_filter :verify_authenticity_token,
  #                   if: Proc.new { |c| c.request.format == 'application/json' }
  #before_filter :authenticate_user_from_token!, except: [:new, :create]

  
  def create
    respond_to do |format|
      format.json do
        if params[:email] && params[:password]
          user = User.find_by_email(params[:email])
          if user && user.valid_password?(params[:password])
            self.resource = user
            sign_in(resource_name, resource)
            access_token = resource.generate_authentication_token
            render json: {
              resource: "resource_server",
              token_type: "Bearer",
              access_token: access_token.token,
            }
          else
            render json: {error: "invalid_input", error_description: "400 error: User input invalid"}, status: :bad_request
          end
        else
          render json: {error: "invalid_input", error_description: "400 error: User input invalid"}, status: :bad_request
        end
      end
      format.all {super}
    end
  end

  def destroy
    respond_to do |format|
      format.json {
        sign_out(resource_name)
        if params[:authentication_token]
          application ||= Doorkeeper::Application.find_by(uid: Doorkeeper::Application.first.uid)
          Doorkeeper::AccessToken.where(application_id: application.id, token: params[:authentication_token]).destroy_all
          session
          render json: {success: true}
        else
          render json: {failiure: true}
        end
      }
      format.all {super}
    end    
  end

  
  
end
