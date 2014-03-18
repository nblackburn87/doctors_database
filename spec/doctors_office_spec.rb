require 'rspec'
require 'Doctor'
require 'Patient'
require 'Specialty'
require 'PG'


DB = PG.connect({:dbname => 'test_doctor_database'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM doctors_specialties *;")
  end
end

describe 'Doctor' do
  describe '#initialize' do
    it 'is initialized with a name' do
      test_doctor = Doctor.new({'name' => 'Kevorkian'})
      test_doctor.should be_an_instance_of Doctor
    end

    it 'tells you its name' do
      test_doctor = Doctor.new({'name' => 'Kevorkian'})
      test_doctor.name.should eq 'Kevorkian'
    end
  end

  describe 'Doctor.all' do
    it 'starts off with no doctors' do
      Doctor.all.should eq []
    end
  end

  describe '#save' do
    it 'adds an instance of doctor to the database' do
      test_doctor = Doctor.new({'name' => 'Kevorkian'})
      test_doctor.save
      Doctor.all.should eq [test_doctor]
    end
  end

  it 'is the same doctor if it has the same name' do
    test_doctor1 = Doctor.new({'name' => 'Kevorkian'})
    test_doctor2 = Doctor.new({'name' => 'Kevorkian'})
    test_doctor1.should eq test_doctor2
  end

  describe 'patients'
    it 'returns all patients assigned to a given doctor' do
      test_doctor = Doctor.new({'name' => 'Freud'})
      test_doctor.save
      test_patient = Patient.new({'name' => 'John', 'birthday' => '1987-12-09', 'doctor_id' => test_doctor.id})
      test_patient.save
      test_doctor.show_patients.should eq [test_patient]
  end
end

describe 'Patient' do
  describe '#initialize' do
    it 'is initialized with a name, birthday, and a doctor' do
      test_patient = Patient.new({'name' => 'John', 'birthday' => '1987-12-09', 'doctor_id' => '2'})
      test_patient.should be_an_instance_of Patient
    end

    it 'tells you its name and birthday' do
      patient = Patient.new({'name' => 'John', 'birthday' => '1987-12-09'})
      patient.name.should eq 'John'
      patient.birthday.should eq '1987-12-09'
    end
  end

  describe 'Patient.all' do
    it 'starts off with no patients' do
      Patient.all.should eq []
    end
  end

  describe '#save' do
    it 'adds an instance of patient to the database' do
      test_patient = Patient.new({'name' => 'John', 'birthday' => '1987-12-09'})
      test_patient.save
      Patient.all.should eq [test_patient]
    end
  end

  it 'is the same patient if it has the same name' do
    test_patient1 = Patient.new({'name' => 'John', 'birthday' => '1987-12-09'})
    test_patient2 = Patient.new({'name' => 'John', 'birthday' => '1987-12-09'})
    test_patient1.should eq test_patient2
  end
end

describe 'Specialty' do
  describe '#initialize' do
    it 'is initialized with a specialty' do
      test_specialty = Specialty.new({'type' => 'Neurosurgery'})
      test_specialty.save
      test_specialty.should be_an_instance_of Specialty
    end
  end
  describe '#save_doctor_to_specialty' do
    it 'saves doctor_id and specialty_id as new entry in doctors_specialties table' do
      test_doctor = Doctor.new({'name' => 'Freud'})
      test_doctor.save
      test_specialty = Specialty.new({'type' => 'Neurosurgery'})
      test_specialty.save
      test_specialty.save_doctor_to_specialty(test_doctor.id)
      puts test_specialty.show_doctors
      test_specialty.show_doctors.should eq [test_doctor]
    end
  end
end
