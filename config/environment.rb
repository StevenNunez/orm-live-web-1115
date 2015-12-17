require 'bundler/setup'
Bundler.require

$: << '.'
# $LOAD_PATH << "."
require 'models/student'

$db = SQLite3::Database.new('db/students.db')
$db.results_as_hash = true
