class SurveysController < ApplicationController
	before_action :ensure_logged_in, except: [:index, :about_us]

  def index
    @surveys =Survey.all
    @user_surveys =[]
	  @survey_images = {}
	  @surveys.each do |survey|
		  @survey_images[survey.id]=HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["Giphy_Key"]}&q=#{survey.name}&rating=g&limit=10")
	  end
  end

  def show
    @survey = Survey.find(params[:id])
    @user= current_user
		@survey_done_today = false
		@user.results.each do |result|
			if result.survey_id == @survey.id && result.created_at.to_date == Date.today
				@survey_done_today = true
			end
		end
  end

	def about_us
	end

end
