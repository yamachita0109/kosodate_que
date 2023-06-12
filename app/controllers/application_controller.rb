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

  def show_notice(messages, now = false)
    meg = messages.join('<br>')
    if now
      flash.now[:notice] = meg
    else
      flash[:notice] = meg
    end
  end

  def show_alert(messages, now = false)
    meg = messages.join('<br>')
    if now
      flash.now[:alert] = meg
    else
      flash[:alert] = meg
    end
  end
end
