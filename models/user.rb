class User < ApplicationModel
  attr_accessor :password, :username

  def self.find_and_verify(username, password)
    return nil if username.nil? || password.nil?
    csv = CSV.read( "database/users.csv", headers: true )
    row = csv.find {|row| row['username'] == username && row['password'] == password }
    if row.nil?
      return puts "No user found, please try again."
    else
      return User.find(row["id"])
    end
  end
end
