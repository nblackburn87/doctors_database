class Patient

  attr_reader :name, :birthday, :id, :doctor_id

  def initialize(attributes)
    @name = attributes['name']
    @birthday = attributes['birthday']
    @doctor_id = attributes['doctor_id']
    @id = attributes['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |result|
      patients << Patient.new(result)
    end
    patients
  end

  def save
    @doctor_id = @doctor_id == nil ? "NULL" : @doctor_id
    results = DB.exec("INSERT INTO patients (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', #{@doctor_id}) RETURNING id")
    @id = results.first['id'].to_i
  end

  def ==(another_patient)
    self.name == another_patient.name
  end
end
