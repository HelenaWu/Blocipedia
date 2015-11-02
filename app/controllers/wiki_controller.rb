class WikiController < ApplicationController
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
      redirect_to wiki_index_path
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
    if @wiki.update_attributes(wiki_params)

      flash[:notice] = "succesfully updated wiki entry."
      redirect_to wiki_path(@wiki)
    else
      flash[:error] = "failed to update wiki entry, please try again."
      render :edit
    end
  end

  def destroy
  end

  private
  def wiki_params
    params.require(:wiki).permit(:subject, :body, :level, :collaboration)
  end
end
