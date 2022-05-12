class AccessByZoneListController < ApplicationController
  def index
		if signed_granted?(current_user.id, 'access_by_zone_list', 'I')
			@zonas = Zona.where("#{current_user.default_level('zonas')}").all.order("zona_id ASC") 
			arrZones = []
			@zonas.each do |zona|
				arrZones.push(zona.id)
			end
			if arrZones.count == 0
				arrZones.push(current_user.usersdefault.access_id)
			end
      @club_users = getZoneClubsUsers(arrZones)
		end
	end
	
	def show	
		if signed_granted?(current_user.id, 'access_by_zone_list', 'I')
			zone_id = params[:zone_id].to_i
			allowedZones = Zona.where("#{current_user.default_level('zonas')}").all.order("zona_id ASC") 
			arrZones = []
			allowedZones.each do |zona|
				arrZones.push(zona.id)
			end
			if arrZones.include? zone_id
				arrZones = [zone_id]
			end
			@club_users = getZoneClubsUsers(arrZones)
			respond_to do |format|
				format.js
			end
		end
	end

	private
	  def getZoneClubsUsers(arrZones)
			users = User.where("users.id IN (SELECT user_id FROM users_defaults WHERE access_level = 'LC' AND zona_id IN (#{arrZones.to_s.gsub("[", "").gsub("]", "")}) ORDER BY zona_id ASC) AND plain_text_initial_password != ''").all.order_by_zone
		end
end