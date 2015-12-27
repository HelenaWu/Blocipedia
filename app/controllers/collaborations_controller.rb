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

  def non_editors_emails
    wiki = Wiki.find(params[:wiki_id])
    email = params[:collaboration][:user]
    if email.blank?
      @emails = []
    else
     @emails = wiki.non_editors.emails_starting_with(email) || []
   end
  end
end
