class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate_barista
    if not current_barista
      flash[:error] = 'Please enter your barista code to begin.'
      redirect_to new_session_url and return
    end
  end

  def current_barista
    return nil if not session[:barista]
    @current_barista ||= Barista.find(session[:barista])
  end

  def login(barista)
    session[:barista] = barista.id
  end
end
