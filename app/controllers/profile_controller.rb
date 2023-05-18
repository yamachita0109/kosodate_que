class ProfileController < ApplicationController
  def show
    @user = User.find_by_hashid params[:id]
    if @user.nil?
      render_404
      return
    end
  end
end
