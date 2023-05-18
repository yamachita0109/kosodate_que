class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  # rescue_from Exception, with: :render_500

  # TODO レイアウト
  def render_404
    render template: 'errors/404', status: 404, layout: 'application', content_type: 'text/html'
  end

  # TODO レイアウト
  def render_500
    render template: 'errors/500', status: 500, layout: 'application', content_type: 'text/html'
  end

  def show_notice(messages)
    # TODO レイアウト
    flash[:notice] = messages.join('<br>')
  end

  def show_alert(messages)
    # TODO レイアウト
    flash[:alert] = messages.join('<br>')
  end
end
