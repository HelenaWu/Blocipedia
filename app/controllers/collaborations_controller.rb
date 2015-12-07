class CollaborationsController < ApplicationController
  def destroy
    @collaboration = Collaboration.find(params[:id])        
    if @collaboration.destroy
      flash[:notice] = "succesfully deleted collaborator"
    else
      flash[:error] = "encountered issue deleting the collaborator"
    end
    respond_to do |format| 
      format.html
      format.js
    end
  end
end
