class StaticPagesController < ApplicationController
  
  
  def home
    if signed_in?  #si esta logueado, recupera los microposts de ese usuario
      #jf @micropost  = current_user.microposts.build
      #jf @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
   
  def help
  end
  
  def about
  end
  
end
