class UsersController < ApplicationController
  before_filter :authorize_admin
    
  # GET /users
  # GET /users.json
  def index
    @users = User.scoped_by_university_id(current_university.id).order("email asc").page(params[:page])
    @sports = Sport.scoped_by_university_id(current_university.id).order("name ASC")
    
    if params[:filter].present?
      if params[:filter] == "admin"
        @users = @users.admins
      elsif params[:filter] == "athlete"
        @users = @users.athletes
      elsif params[:filter] != "all"
        @users = User.includes(:sport).scoped_by_university_id(current_university.id).where("sports.name like '#{params[:filter]}'").order("users.name asc").page(params[:page])
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  # GET /users/1/edit
  def edit
   @user = User.scoped_by_university_id(current_university.id).find(params[:id])
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
   @user = User.scoped_by_university_id(current_university.id).find(params[:id])

   respond_to do |format|
     if @user.update_attributes(params[:user])
       format.html { redirect_to users_path, notice: 'User was successfully updated.' }
       format.json { head :no_content }
     else
       format.html { render action: "edit" }
       format.json { render json: @user.errors, status: :unprocessable_entity }
     end
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
