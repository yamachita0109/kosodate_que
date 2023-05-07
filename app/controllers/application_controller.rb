class ApplicationController < ActionController::Base

  def show_notice(messages)
    # TODO レイアウト
    flash[:notice] = messages.join('<br>')
  end

  def show_alert(messages)
    # TODO レイアウト
    flash[:alert] = messages.join('<br>')
  end
end
