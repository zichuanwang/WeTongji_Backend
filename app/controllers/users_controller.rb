class UsersController < ApplicationController
	before_filter :authenticate_admin!, :except => [:confirmation, :welcome, :reset_password, :reset_password_sucess]
  def index
    @users = User.order('id desc')
    if (params[:type] == "unconfirmed")
      @users = @users.where("confirmed_at is null")
    end
    unless params[:no].blank?
      @users = @users.where("no = :no", :no => params[:no])
    end
    unless params[:name].blank?
      @users = @users.where("name = :name", :name => params[:name])
    end
    @users = @users.page(params[:page])
    @menu = "users"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def reconfirm
    user = User.find(params[:id])
    if user
      UserMailer.confirmation(user).deliver
    end
    redirect_to :action => "index"
  end

  def send_reset_password_mail
    user = User.find(params[:id])
    if user
      user.send_reset_password_mail
      user.save
    end
    redirect_to :action => "index"
  end

  def reset_password_from_mail
    @user = User.find_by_reset_password_token(params[:token])
    render :layout => "out"
  end

  def reset_password
    if params[:password] == params[:password_confirmation] && User.is_password_valid?(params[:password])
      @user = User.find_by_reset_password_token(params[:token])
      unless @user
        @user.password = params[:password]
        @user.reset_password_token = ''
        @user.save
        redirect_to :action => "reset_password_success"
      end
    end

    render :layout => "out"
  end

  def reset_password_success
    render :layout => "out"
  end

  def confirmation
  	user = User.find_by_confirmation_token(params[:token])
  	if user && user.confirmed_at == nil
  		user.confirmed_at = Time.now
  		user.save
  		UserMailer.welcome(user).deliver
  		redirect_to :action => "welcome"
  	else
  		render :layout => "out"
  	end
  end

  def welcome
  	render :layout => "out"
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
