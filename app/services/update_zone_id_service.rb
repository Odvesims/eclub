class UpdateZoneIdService

  attr_accessor :level, :id, :zone_id

  def initialize(service_params)
    @level = service_params[:level]
    @id = service_params[:id]
    @zone_id = service_params[:zone_id]
  end

  def execute
    case level
      when 'DS'
        district = Distrito.find(id)
        district.zona_id = zone_id
        begin
          district.save
          churches = Iglesia.where("distrito_id = #{district.id}")
          churches.each do |church|
            clubs = Iglesiasclube.where("iglesia_id = #{church.id}").all
            clubs.each do |club|
              updateClub(club)              
            end
            updateChurch(church)
          end
        rescue Exception => e
          Rails.logger.debug("Exception: #{e.message}")
          return { valid: false, message: "No se pudo actualizar la zona: #{e.message} " }
        end
      when 'CH'
        church = Iglesia.find(id)
        begin
          updateChurch()
          clubs = Iglesiasclube.where("iglesia_id = #{church.id}").all
          clubs.each do |club|
            updateClub(club)              
          end
        rescue Exception => e
          return { valid: false, message: "No se pudo actualizar la zona: #{e.message} " }
        end
      when 'CL'
        club = Iglesiasclube.find(id)
        begin
          updateClub(club)
        rescue Exception => e
          return { valid: false, message: "No se pudo actualizar la zona: #{e.message} " }
        end
    end
    return { valid: true, message: 'Zona actualizada' }
  end

  private

    def updateChurch(church)
      church.zona_id = zone_id
      church.save!
    end

    def updateClub(club)
      points = Camporeespuntuacionescab.where("iglesiasclube_id = #{club.id}").all
      points.each do |point|
        point.zona_id = zone_id
        point.save!
      end
      club.zona_id = zone_id
      club.save!
    end

end