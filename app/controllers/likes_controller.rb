class LikesController < ApplicationController
  def create
    # return redirect_to new_session_path unless current_user
    @like = Like.create(secret:Secret.find(params[:secret_id]), user:current_user)
    if @like.invalid? 
      flash[:errors] = @like.errors.full_messages
    end 
    redirect_to :back     
  end

  def destroy
    # return redirect_to new_session_path unless current_user 
    @like =  Like.find(params[:id])
    @like.destroy  if current_user === @like.user
    redirect_to :back
  end

  private
    def like_params
      params.require(:like).permit(:secret_id).merge(user: current_user)
    end
 
end
