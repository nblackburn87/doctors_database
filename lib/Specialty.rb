require 'pry'
class Specialty

  attr_reader :name, :doctor_id, :id

  def initialize(attributes)
    @type = attributes['type']
    @id = attributes['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM specialty;")
    specialties = []
    results.each do |result|
      specialties << Specialty.new(result)
    end
    specialties
  end

  def show_doctors
    #this fetches all doctors in a specialty
    results = DB.exec("SELECT * FROM doctors_specialties WHERE specialty_id = #{@id}")
    # binding.pry
    doctors = []
    results.each do |object|
      object_doctor_id = object["doctor_id"]
      doctor_object = DB.exec("SELECT * FROM doctors WHERE id = #{object_doctor_id};")
      doctors << Doctor.new(doctor_object.first)
    end
    doctors
  end

  def save
    results = DB.exec("INSERT INTO specialty (specialty_type) VALUES ('#{@type}') RETURNING id")
    @id = results.first['id'].to_i
  end

  def save_doctor_to_specialty(doctor_id)
    DB.exec("INSERT INTO doctors_specialties (specialty_id, doctor_id) VALUES ('#{@id}', '#{doctor_id}')")
  end

  # def print_doctors_in_specialty
  #   result = DB.exec("SELECT * FROM doctors_specialties WHERE id = #{@id}")
  # end
end
