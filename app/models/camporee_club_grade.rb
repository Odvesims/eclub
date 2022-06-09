class CamporeeClubGrade < ActiveRecord::Base

  self.table_name = "camporee_club_grades"

  def grade_details
    JSON.parse(self.details)
  end

  def zone_name
    club = Iglesiasclube.find(self.club_id)
    zone = Zona.find(club.zona_id)
    zone.nombre
  end

  def club_name
    club = Iglesiasclube.find(self.club_id)
    club.nombre
  end

  def conference_name
    club = Iglesiasclube.find(self.club_id)
    conference = Campo.find(club.campo_id)
    conference.nombre
  end

  def camporee_name
    camporee = Camporee.find(self.camporee_id)    
    camporee.nombre
  end

  def event_name
    event = Camporeesevento.find(self.event_id)
    event.nombre
  end

  def event_category_name
    event = Camporeesevento.find(self.event_id)
    category = Camporeesrenglone.find(event.camporeesrenglone_id)
    category.nombre
  end

end