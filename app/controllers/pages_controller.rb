class PagesController < ApplicationController
  def show
    render action: params[:id]
  end
end
