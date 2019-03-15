require 'directory'

describe StudentDirectory do
  it 'gives menu options' do
    sd = StudentDirectory.new
    expect(sd.print_menu).to include "1. Input the students"
  end

  it 'lets you add students' do
    sd = StudentDirectory.new
    sd.students_into_hash("Jim", "July")
    expect(sd.students).to eq [{:name=>"Jim", :cohort=>:July}]
  end

  it 'counts students' do
    sd = StudentDirectory.new
    sd.students_into_hash("Jim", "July")
    expect(sd.student_counter).to eq "Now we have 1 student"
  end

  it 'saves and loads new students in csv' do
    sd = StudentDirectory.new
    sd.students_into_hash("Test", "Test")
    filename = "test.csv"
    sd.save_students_new(filename)
    sd = StudentDirectory.new
    sd.load_students(filename)
    expect(sd.students).to eq [{:name=>"Test", :cohort=>:Test}]
    File.delete("test.csv")
  end

  it 'lets you remove students' do
    sd = StudentDirectory.new
    sd.students_into_hash("Jim", "July")
    sd.remove_student("Jim", "July")
    expect(sd.students).to eq []
  end

  it 'lets you overwrite existing csvs' do
    sd = StudentDirectory.new
    sd.students_into_hash("Test", "Test")
    filename = "test.csv"
    sd.save_students_new(filename)
    sd = StudentDirectory.new
    sd.students_into_hash("Over", "Write")
    sd.save_students_ow(filename)
    sd = StudentDirectory.new
    sd.load_students(filename)
    expect(sd.students).to eq [{:name=>"Over", :cohort=>:Write}]
    File.delete("test.csv")
  end

  it 'lets you add to existing previous csvs' do
    sd = StudentDirectory.new
    sd.students_into_hash("Test", "Test")
    filename = "test.csv"
    sd.save_students_new(filename)
    sd = StudentDirectory.new
    sd.students_into_hash("Over", "Write")
    sd.save_students_apnd(filename)
    sd = StudentDirectory.new
    sd.load_students(filename)
    expect(sd.students).to eq [{:name=>"Test", :cohort=>:Test}, {:name=>"Over", :cohort=>:Write}]
    File.delete("test.csv")
  end

  it 'lets you delete a csv file' do
    sd = StudentDirectory.new
    sd.students_into_hash("Test", "Test")
    filename = "test.csv"
    sd.save_students_new(filename)
    sd.delete_csv_file(filename)
    expect(File.exists?(filename)).to eq false
  end

end
