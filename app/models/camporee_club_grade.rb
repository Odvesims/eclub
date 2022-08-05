class CamporeeClubGrade < ActiveRecord::Base

  self.table_name = "camporee_club_grades"

  def grade_details
    JSON.parse(self.details)
  end

  def zone_name
    begin
    club = Iglesiasclube.find(self.club_id)
    zone = Zona.find(club.zona_id)
    zone.nombre
    rescue 
      false
    end
  end

  def club_name
    begin
    club = Iglesiasclube.find(self.club_id)
    club.nombre
    rescue
      false
    end
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

  def judge_name
    judge = CamporeeJudge.find(self.camporee_judge_id)
    judge.name
  end

  def registered_by
    user = User.where("login = '#{self.updated_by}'").first
    user.name
  end

end