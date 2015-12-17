describe Student do
  it "converts a set row to an object" do
    row = {"id"=>1, "name"=>"Poppa Chris", "super_power"=>"infinite face-palm", 0=>1, 1=>"Poppa Chris", 2=>"infinite face-palm"}
    student = Student.new_from_row(row)
    expect(student.id).to eq(1)
    expect(student.name).to eq("Poppa Chris")
    expect(student.super_power).to eq("infinite face-palm")
  end

  context "Finders" do
    it "returns all students as Active Record Objects" do
      students = Student.all
      first_student = students.first
      expect(first_student).to be_a(Student)
      expect(first_student.name).to eq("Poppa Chris")
      expect(students.count).to eq(29)
    end

    it "finds a student by id" do
      student = Student.find(7)
      expect(student.name).to eq("Josh")
      expect(student.super_power).to eq("None")
    end

    it "finds a student by name" do
      student = Student.find_by_name("Josh")
      expect(student.id).to eq(7)
      expect(student.name).to eq("Josh")
      expect(student.super_power).to eq("None")
    end
    it "isn't vulnerable to sql injection" do
      student = Student.find_by_name('bob" OR id=1; --')
      expect(student).to be_nil
    end
  end
  context "Persisting" do
    # Update the database and insert into it the
    # data in the Active Record
    before do
      student = Student.find_by_name("Steven")
      student.delete if student
    end

    it "saves new instances to the database" do
      steven = Student.new(nil, "Steven", "Time Travel")
      steven.save
      expect(Student.find_by_name("Steven")).not_to be_nil
    end
  end
end
