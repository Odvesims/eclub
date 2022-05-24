class AccessControlController < ApplicationController

  def index
		if signed_granted?(current_user.id, 'access_control', 'I')
    end
  end

  def show
		if signed_granted?(current_user.id, 'access_control', 'I')
      minimum_level = params[:minimum_level].to_i
      access_control = AccessControl.first
      access_control.minimum_level = minimum_level
      access_control.save!
      #ActiveRecord::Base.connection.execute("UPDATE access_restricted set estatus = true, minimum_level = #{minimum_level}")
      respond_to do |format|
        format.js
      end
    end
  end

end