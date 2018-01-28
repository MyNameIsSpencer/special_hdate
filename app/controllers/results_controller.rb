class ResultsController < ApplicationController

  def create
    @result = Result.new
    @result.user_id = current_user.id
    @result.survey_id = params[:results][:survey_id]
    @result.answers =params[:results][:answers]
    @result.save
  end

end
