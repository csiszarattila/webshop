require 'csv'
require 'models/zipcode'

module ZipcodeMatch 
	# Import data from a csv file and load it into db.
	# Use Zipcode ActiveRecord model.
	def self.import_from_csv
		datadir = File.join(File.dirname(__FILE__), 'data')
		
		CSV::Reader.parse(File.open(File.join(datadir, 'ir.csv'),'rb')) do |row|
			Zipcode.create do |z|
			 	z.zipcode = row[0].to_i
			 	z.city = row[1].to_s
			end
		end
		
		CSV::Reader.parse(File.open(File.join(datadir,'ir_bp.csv'),'rb')) do |row|
			Zipcode.create do |z|
				z.zipcode = row[0].to_i
				z.city = "Budapest"
			end
		end
	end
	
	def self.delete_from_db
		Zipcode.delete_all
	end
	
	def self.city_exist?(city)
		return true unless Zipcode.find_by_city(city).nil?
		false
	end
	
	def self.zipcode_exist?(zipcode)
		return true unless Zipcode.find_by_zipcode(zipcode).nil?
		false
	end
	
	# Checks whether city and zipcode are match with each other.
	# Note: some city has many zipcodes
	def self.match?(city, zipcode)
		Zipcode.find_all_by_city(city).collect(&:zipcode).include?(zipcode)
	end
	
	# Find city for given zipcode
	def self.city_with_zipcode(zipcode)
		zip = Zipcode.find_by_zipcode(zipcode)
		return zip.city unless zip.nil?
		zip
	end
	
	# Find zipcodes 
	# Note: this method is in plural because some city has many zipcodes
	def self.zipcodes_for_city(city)
		zip = Zipcode.find_by_city(city)
		return zip.collect(&zipcode) unless zip.nil?
		zip
	end
end