class CustomUsersController < ApplicationController

  def index
		if signed_granted?(current_user.id, 'access_control', 'I')
    end
  end

  def show
		if signed_granted?(current_user.id, 'access_control', 'I')
      roles = []
      begin
        params[:roles].each do |rol|
          roles.push({rol_id: rol})
        end
      rescue
      end
      @new_user_result = GenerateCustomUserService.new({ login: params[:login], name: params[:name], password: params[:password], access_id: params[:access_id], access_level: params[:access_level], zone_id: params[:zone_id], club_type: current_user.club_type, default_camporee: current_user.default_camporee, default_conference: current_user.default_conference, roles: roles, rol_id: params[:rol_id], admin: params[:administrator] }).execute
      respond_to do |format|
        format.js
      end
    end
  end

end