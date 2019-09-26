class ApplicationModel
  attr_reader :attributes, :id, :model

  # Find =======================================================================
  def self.find(id)
    self.new(id: id) # Record gets found by ID
  end

  # Create =====================================================================
  def self.create(options = {  })
    return self unless options[:id].nil? # If ID present returns self
    new_object = self.new(options)
    new_object.save # Record gets created and saved
  end

  # ============================================================================

  # All ========================================================================
  def self.all
    models_array = []
    @db_model = self.to_s.downcase
    CSV.foreach("database/#{@db_model}s.csv", headers: true) do |row|
      models_array = models_array.push(self.find(row[0]))
    end
    models_array.each do |model_instant|
      model_instant
    end
  end

  # Sort Database ==============================================================
  def self.sort_database
    rows = []
    model_array = []
    @db_model = self.to_s.downcase
    CSV.foreach("database/#{@db_model}s.csv", headers: true) do |row|
      rows << row.to_h
    end
    sorted_rows = rows.sort_by{ |row| row['id'] }

    sorted_rows.each do |row|
      model_array = model_array.push(self.find(row['id']))
    end
    model_array.each do |model|
      model.save
    end
  end

  # Return Attributes Hash =====================================================
  def return_attributes_hash
    attributes_hash = {  }
    attributes.map  do |attribute| #Creates a hash of Record attributes
      attributes_hash[attribute] = send(attribute.to_sym)
    end
    attributes_hash
  end

  # Destroy ====================================================================
  def destroy
    attributes_hash = self.return_attributes_hash
    attributes_hash["id"] = 0

    csv = CSV.table("database/#{@model}s.csv", headers: true)
    File.delete("database/#{@model}s.csv") if File.exist?("database/#{@model}s.csv")
    csv.delete_if {|row| row[:id] == id.to_i}

    File.open("database/#{@model}s.csv", 'w') do |f|
      f.write(csv.to_csv)
    end

    CSV.open("database/#{@model}s.csv", "a+") do |row|
      row << attributes_hash.values
    end

    self.class.sort_database
  end

  # Update =====================================================================
  def update(options = {  })
    if id.nil?
      puts "#{@model.capitalize} doesnt exist."
      return
    else
      options.each do |key, value|
        self.send("#{key}=", value)
      end
      self.save
    end
  end

  # Initialize =================================================================
  def initialize(options = {  })
    @model      = "#{self.class.to_s.downcase}"
    @attributes = CSV.read("database/#{@model}s.csv", headers: true).headers

    if options[:id].nil? # Creates instance variables if ID is nil
      @attributes.each do |attribute|
        instance_variable_set("@#{attribute}", options[attribute.to_sym])
      end

    else # Finds instance variables if ID present
      csv = CSV.read("database/#{@model}s.csv", headers: true)
      row = csv.find {|row| row['id'] == options[:id].to_s }.to_h

      row.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end

  # Save =======================================================================
  def save
    attributes_hash = self.return_attributes_hash

    if id.nil? # New record saved to CSV file
      puts "#{@model.capitalize} Created."
      attributes_hash["id"] = [CSV.read("database/#{@model}s.csv").count][0]
      CSV.open("database/#{@model}s.csv", "a+") do |row|
        row << attributes_hash.values
      end
      return true
    else # Updates existing CSV row with new record information
      puts "#{@model.capitalize} Updated."

      csv = CSV.table("database/#{@model}s.csv", headers: true)

      attributes_array = [] # creates array of new data to update csv file
      attributes_hash.each do |k,v|
        attributes_array = attributes_array.push(v)
      end

      File.delete("database/#{@model}s.csv") if File.exist?("database/#{@model}s.csv")

      csv.delete_if {|row| row[:id] == id.to_i}

      File.open("database/#{@model}s.csv", 'w') do |f|
        f.write(csv.to_csv)
      end

      CSV.open("database/#{@model}s.csv", "a+") do |row|
        row << attributes_array
      end
      return true
    end
  end
end
