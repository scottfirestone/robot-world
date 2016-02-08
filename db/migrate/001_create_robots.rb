require 'sequel'

environments = ["test", "dev"]

environments.each do |env|
  Sequel.sqlite("db/robot_world_#{env}.sqlite3").create_table(:robots) do
    primary_key :id
    String :name
    String :city
    String :avatar
    Date :birthdate
    Date :date_hired
    String :department
  end
end
