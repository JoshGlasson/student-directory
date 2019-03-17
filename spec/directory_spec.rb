require 'directory'

describe StudentDirectory do

#  subject = Desribed_Class.new

  it 'gives menu options' do
    expect(subject.print_menu).to include "1. Input the students"
  end

  it 'lets you add students' do
    subject.students_into_hash("Jim", "July")
    expect(subject.students).to eq [{:name=>"Jim", :cohort=>:July}]
  end

  it 'counts students' do
    subject.students_into_hash("Jim", "July")
    expect(subject.student_counter).to eq "Now we have 1 student"
  end

  it 'loads students from csv' do
    filename = "loadtest.csv"
    subject.load_students(filename)
    expect(subject.students).to eq [{:name=>"Load", :cohort=>:Test}]
  end

  it 'saves students into csv' do
    subject.students_into_hash("Test", "Test")
    filename = "savetest.csv"
    subject.save_students_new(filename)
    subject.clear_list
    file = File.open(filename, "r")
    file.readlines.each do |line|
      name, cohort = line.chomp.split(',')
      subject.students_into_hash(name, cohort)
    end
    expect(subject.students).to eq [{:name=>"Test", :cohort=>:Test}]
    File.delete("savetest.csv")
  end

  it 'lets you remove students' do
    subject.students_into_hash("Jim", "July")
    subject.remove_student("Jim", "July")
    expect(subject.students).to eq []
  end

  it 'lets you overwrite existing csvs' do
    subject.students_into_hash("Test", "Test")
    filename = "test.csv"
    subject.save_students_new(filename)
    subject.clear_list
    subject.students_into_hash("Over", "Write")
    subject.save_students_ow(filename)
    subject.clear_list
    subject.load_students(filename)
    expect(subject.students).to eq [{:name=>"Over", :cohort=>:Write}]
    File.delete("test.csv")
  end

  it 'lets you add to existing previous csvs' do
    subject.students_into_hash("Test", "Test")
    filename = "test.csv"
    subject.save_students_new(filename)
    subject.clear_list
    subject.students_into_hash("Over", "Write")
    subject.save_students_apnd(filename)
    subject.clear_list
    subject.load_students(filename)
    expect(subject.students).to eq [{:name=>"Test", :cohort=>:Test}, {:name=>"Over", :cohort=>:Write}]
    File.delete("test.csv")
  end

  it 'lets you delete a csv file' do
    subject.students_into_hash("Test", "Test")
    filename = "test.csv"
    subject.save_students_new(filename)
    subject.delete_csv_file(filename)
    expect(File.exists?(filename)).to eq false
  end

  it 'lets you clear the array' do
    subject.students_into_hash("Test", "Test")
    subject.clear_list
    expect(subject.students).to eq []
  end

  it 'sorts and displays cohort by month' do
    filename = "sorttest.csv"
    subject.load_students(filename)
    cohort = "January"
    expect(subject.show_cohort(cohort)).to eq "In the #{cohort} cohort: Test Jan1, Test Jan2"
  end

end
