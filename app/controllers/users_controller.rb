class UsersController < ApplicationController
	before_action :ensure_logged_in, except: [:new, :create]

  def new
		@user = User.new
	end


  def create
    @user = User.create(user_params)
    if @user.save
      @user.update(status: 'Online')
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @users = User.all
    @user = User.find(params[:id])
    unless current_user.user_matches.include?(@user) || @user ==current_user
      redirect_to new_session_path
    end
    if  @user.blocks.include?(current_user.id)
      flash[:notice] = "Cannot access profile.  You have been blocked."
      redirect_to user_matches_url(current_user.id)
    end
    @results = Result.all
    @surveys= Survey.all
  end

  def find_user
    @user = current_user
    @found_users = User.where("pet_peeves ILIKE ?", "%#{params[:search]}%")
    render :show
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update!(user_params)
    if @user.save
      redirect_to user_url
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    session[:user_id] = nil
    @user.delete_user_results
    @user.destroy
    redirect_to new_user_url
  end

  def load_matches
    @user = current_user
    @users = User.all
    @results = Result.all
    @surveys = Survey.all
    @received_messages = Message.where("receiver_id = ?", current_user.id)
    @sent_messages = Message.where("user_id = ?", current_user.id)
  end

  def meetups
	  @user = current_user
	  @user_surveys = []
	  @user_meetups = []
	  @user.results.each do |result|
		  if @user_surveys.include?(Survey.all.find(result.survey_id).name) == false
			  @user_surveys << Survey.all.find(result.survey_id).name
		  end
	  end
	  @user_surveys.each do |survey|
		  if @user.fsa
			  result = HTTParty.get("https://api.meetup.com/find/groups?&key=#{ENV["Meetup_Key"]}&sign=true&photo-host=public&country=CA&text=#{survey}&page=20&lat=#{@user.fsa.latitude}&lon=#{@user.fsa.longitude}&radius=100")
		  else
			  result = HTTParty.get("https://api.meetup.com/find/groups?&key=#{ENV["Meetup_Key"]}&sign=true&photo-host=public&country=CA&text=#{survey}&page=20")
		  end
			@user_meetups << result
	  end
  end

  def change_status
    @user = current_user
    @user.update(status: params[:user][:status])
  end

  def block_user
    @user=current_user
    receiver_id = params[:receiver].to_i
    @user.blocks<<receiver_id unless @user.blocks.include?(receiver_id)
    @user.save
    redirect_to user_matches_url(@user.id)
  end

  private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

  def user_params
    params.require(:user).permit(:avatar, :fsa_id, :name, :email, :phone, :privacy, :password, :password_confirmation, :fsa_id, :pet_peeves, :description)
  end

end
