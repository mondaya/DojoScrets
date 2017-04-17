class SecretsController < ApplicationController

  before_action :require_secret_auth, only: [:destroy]

  def index
     # return redirect_to new_session_path unless current_user 
    @secrets = Secret.all
  end

  def create
    # return redirect_to new_session_path unless current_user 
    @secret =  Secret.create(content:params[:Content], user:current_user)
    if @secret.invalid?
      flash[:errors] = @secret.errors.full_messages
    end
    redirect_to :back
  end

  def destroy
    # return redirect_to new_session_path unless current_user 
    @secret =  Secret.find(params[:id])
    @secret.destroy
    redirect_to user_path(current_user)
  end

  private 
  def require_secret_auth 
        redirect_to action: "index" , controller: "secrets"  unless current_user.id  == Secret.find(params[:id]).user.id
  end 
end
