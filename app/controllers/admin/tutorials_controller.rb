class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)

    if @tutorial.save
      flash[:success] = 'Successfully created tutorial.'
      redirect_to tutorial_path(id: @tutorial.id)
    else
      flash[:warning] = 'Please use a valid Youtube video thumbnail.'
      render new_admin_tutorial_path
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_tag_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end

  def tutorial_tag_params
    params.require(:tutorial).permit(:tag_list)
  end
end
