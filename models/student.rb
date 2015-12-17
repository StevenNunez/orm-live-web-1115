class Student
  attr_reader :id, :name, :super_power
  def self.new_from_row(row)
    id, name, super_power =
          row.values_at("id", "name", "super_power")

    self.new(id, name, super_power)
  end

  def self.all
    sql = <<-SQL
      SELECT *
      FROM students
    SQL

    results = $db.execute(sql)
    results.map do |student|
      Student.new_from_row(student)
    end
  end

  def self.find(id)
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE id = #{id}
      LIMIT 1
    SQL

    results = $db.execute(sql)

    results.map do |student|
      Student.new_from_row(student)
    end.first
  end

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE name = ?
      LIMIT 1
    SQL

    results = $db.execute(sql, name)

    results.map do |student|
      Student.new_from_row(student)
    end.first
  end
  def initialize(id, name, super_power)
    @id = id
    @name = name
    @super_power = super_power
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, super_power)
      VALUES (?, ?)
    SQL
    $db.execute(sql, self.name, self.super_power)
  end

  def delete
    sql = <<-SQL
      DELETE FROM students
      WHERE id = ?
    SQL

    $db.execute(sql, self.id)
  end
end
