class QuestionsController < ApplicationController

  def load_pictures
    @survey = Survey.find_by(id: params[:survey_id])
    @pictures = []
    left_pic = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["Giphy_Key"]}&q=#{@survey.questions[params[:number].to_i].option_a}&rating=g")
    right_pic = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["Giphy_Key"]}&q=#{@survey.questions[params[:number].to_i].option_b}&rating=g")
    # @survey.questions[params[:number].to_i].save_picture_if_none_in_database(left_pic, right_pic)
    @pictures << left_pic
    @pictures << right_pic
    @pictures << @survey.questions.length
    @pictures << @survey.questions[params[:number].to_i].option_a
    @pictures << @survey.questions[params[:number].to_i].option_b
    respond_to do |format|
      format.html
      format.json { render :json => @pictures }
    end
  end

end
