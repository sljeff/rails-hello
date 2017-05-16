class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: 'Hello, Jeff!'
  end

  def goodbye
    render html: 'Good Bye! World!'
  end
end
