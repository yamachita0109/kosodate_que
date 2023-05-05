class ApplicationController < ActionController::Base
  def show_alert(messages)
    # TODO レイアウト
    flash[:alert] = messages.join('<br>')
  end
end
