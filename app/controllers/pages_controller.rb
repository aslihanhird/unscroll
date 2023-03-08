class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    redirect_to lists_path
  end

  def profile
    redirect_to root_path unless user_signed_in?
  end
end
