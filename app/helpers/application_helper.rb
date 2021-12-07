module ApplicationHelper

	def nav_link(text, controller, action="index")
    link_to_unless_current text, :controller => controller, :action => action
  end
  
  def current_action?(options)
    url_string = CGI.escapeHTML(url_for(options))
    params = ActionController::Routing::Routes.recognize_path(url_string, :method => :get)
    params[:controller] == @controller.controller_name && params[:action] == @controller.action_name
  end

  def current_controller?(options)
    url_string = CGI.escapeHTML(url_for(options))
    params = ActionController::Routing::Routes.recognize_path(url_string, :method => :get)
    params[:controller] == @controller.controller_name
  end

end
