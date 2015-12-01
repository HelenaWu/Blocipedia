class WikisController < ApplicationController
  def index
    @wikis = Wiki.where(level: 'public')
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params) 
    authorize @wiki 
    if current_user
      @wiki.user_id = current_user.id
    end

    if @wiki.save
      flash[:notice] = "wiki has been created successfully."
      redirect_to wikis_path
    else
      flash[:error] = "there was a problem creating the wiki."
      render :new
    end
  end
  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @collaboration = @wiki.collaborations.new
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if params[:collaboration][:user] != ""
      @user = User.find_by!(email: params[:collaboration][:user])
      @wiki.collaborations.create!(user: @user)
    end

    if @wiki.update_attributes(wiki_params)

      flash[:notice] = "succesfully updated wiki entry."
      redirect_to wiki_path(@wiki)
    else
      flash[:error] = "failed to update wiki entry, please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "wiki has been removed."
      redirect_to wikis_path
    else
      flash[:error] = "there was a problem deleting the wiki."
      redirect_to wiki_path(@wiki)
    end

  end

  private
  def wiki_params
    params.require(:wiki).permit(:subject, :body, :level)
  end
end
