class AppController < ApplicationController
  def index
    if current_user
      redirect_to list_url
    end
  end
end
