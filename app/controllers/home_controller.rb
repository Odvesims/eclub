class HomeController < ApplicationController
before_filter :signed_in_user
  def index
     @menuitem = params[:itemnode]
	 #puts "mi item", @menuitem
     @user = current_user
	 if (@menuitem == nil) || (@menuitem.rstrip == '')
	   @menuitem = '00'
	 end
  end
end
