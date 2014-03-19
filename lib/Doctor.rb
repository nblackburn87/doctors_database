require 'pry'

class Doctor

  attr_reader :name, :id


  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      doctors << Doctor.new(result)
    end
    doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name) VALUES ('#{@name}') RETURNING id")
    @id = results.first['id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end

  def show_patients
    results = DB.exec("SELECT * FROM patients WHERE doctor_id = #{@id};")
    patients = []
    results.each do |result|
      patients << Patient.new(result)
    end
    patients
  end
end
