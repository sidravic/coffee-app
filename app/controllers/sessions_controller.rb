class SessionsController < ApplicationController
  before_action :authenticate_barista

  def new
  end

  def create
    barista = Barista.find_by_code(params[:barista_code])

    if barista
      login(barista)
      redirect_to orders_url
    else
      flash[:error] = 'A Valid Barista code is needed.'
      render 'new'
    end
  end

  def destroy

  end
end