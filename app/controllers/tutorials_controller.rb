class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.classroom?
      require_current_user
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    else
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end
end
