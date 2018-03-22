
require_dependency Rails.root.join('app', 'models', 'user').to_s

class User

	belongs_to :verified_by, class_name: "User", foreign_key: "verified_by_id" #, counter_cache: :verified_by_id

  validates :district, presence: true
  validates :inscription, acceptance: true

	DISTRICT = [["Alfocea", 16], ["Actur-Rey Fernando", 1], ["Barrios del Sur", 30], ["Casablanca", 2], ["Casco Histórico", 3], ["Casetas", 17], ["Centro", 4], ["Delicias", 5], ["El Rabal", 6], ["Garrapinillos", 18], ["Juslibol", 19], ["La Almozara", 7], ["La Cartuja Baja", 20], ["Las Fuentes", 8], ["Miralbueno", 9], ["Montañana", 21], ["Monzalbarba", 22], ["Movera", 23], ["Oliver-Valdefierro", 0], ["Peñaflor", 24], ["San Gregorio", 25], ["San José", 11], ["San Juan de Mozarrifar", 26], ["Santa Isabel", 12], ["Torrecilla del Valmadrid", 27], ["Torrero", 13], ["Universidad", 14], ["Venta del Olivar", 28], ["Villarrapa", 29]]

  def district_name
    User::DISTRICT.select{|v| v[1] == self.district }[0][0]
  end

  validates :born_at, inclusion: { in: Date.civil(1900, 1, 1)..Date.today-16.years,
    message: "debes ser mayor de 16 años" }, allow_blank: true

  before_validation :set_location

  def set_location
    self.country = "ES" if self.country.nil?
    self.province = "Z" if self.province.nil?
    self.town = "m_50_297_3" if self.town.nil?
  end

  def is_verified?
    if Rails.application.secrets.features["verification_presencial"]
      self.verified_by_id? or self.sms_confirmed_at?
    else
      self.verified?
    end
  end

  def vote_district_numeric
    "%02d" % + self.district
  end

  def vote_district_name
    self.district_name
  end

  def vote_district_code
    "d_%02d" % + self.district
  end

  def verify! user
    self.verified_at = DateTime.now
    self.verified_by = user
    self.save
    VerificationMailer.verified(self).deliver
  end

end
