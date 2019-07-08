class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    require_current_user if tutorial.classroom?
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
