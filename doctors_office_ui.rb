require './lib/Doctor'
require './lib/Patient'
require './lib/Specialty'
require 'PG'

DB = PG.connect({:dbname => 'doctor_db'})

def reset_tables
  DB.exec("TRUNCATE TABLE doctors RESTART IDENTITY")
  DB.exec("TRUNCATE TABLE patients RESTART IDENTITY")
  DB.exec("TRUNCATE TABLE specialty RESTART IDENTITY")
  DB.exec("TRUNCATE TABLE doctors_specialties RESTART IDENTITY")
end

def main_menu
  puts "Press 'd' to add a new doctor."
  puts "Press 'p' to add a new patient."
  puts "Press 'a' to assign a patient to a doctor."
  puts "Press 'l' to list all doctors for a given specialty."
  puts "Press 'x' to leave."

  menu_choice = gets.chomp

  case menu_choice
  when 'd'
    add_doctor
  when 'p'
    add_patient
  when 'a'
    pair_doctor_patient
  when 'l'
    list_specialties
  when 'x'
    puts "Thank you."
  else
    puts "Please choose a valid input.\n"
    main_menu
  end
end

def add_doctor
  puts "Please input the doctor's name:"
  user_input = gets.chomp
  new_doctor = Doctor.new({"name" => user_input})
  puts "What is this doctor's specialty?"
  user_input = gets.chomp
  if Specialty.all.include? user_input
    Specialty.all.each do |specialty|
      if specialty.type == user_input
        specialty.save_doctor_to_specialty(new_doctor.id)
      end
    end
  else
    new_specialty = Specialty.new({"type" => user_input})
  end
  main_menu
end

def add_patient

end

def pair_doctor_patient

end

def list_specialties

end

main_menu






