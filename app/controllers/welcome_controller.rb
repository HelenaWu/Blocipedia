class WelcomeController < ApplicationController
  def index
    @wikis = Wiki.where(level: 'public')
  end
end
