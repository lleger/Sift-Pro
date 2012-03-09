class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.scoped_by_university_id(current_university.id).order("email asc").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.scoped_by_university_id(current_university.id).find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
