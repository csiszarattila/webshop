require 'test_helper'
require 'test/mocks/zipcode_match.rb'

class AddressTest < ActiveSupport::TestCase
	def setup		
		@valid_telephone_numbers = [
			"06/30/622/3456", 
			"06-30-622-3456", 
			"06 30 622 3456", 
			"06/30 622 3456",
			"30 6223456"]
			
		@expected_number = "06306223456" #how we store in db
		@read_tel_as = ""#how we get back in formatted way
		
		@invalid_telephone_numbers = [
			"abc234",
			"234abc",
			"2",
			"234",
			"30235",
			"302302"
			]
			
		@valid_email_addresses = [
			"csiszar.ati@gmail.com",
			"stevejobs@apple.com",
			"bill-gates@micro-soft.com",
			"news@office.bbc.co.uk"]
			
		@invalid_email_addresses = [
			"csiszár.ati@gémél.com",
			"csiszar ati@gmail.com",
			"csiszar.ati@gmail com",
			"csiszar.ati kukac gmail pont com"]
		
		@valid_street_addresses = [
				"Batthyány út 99. 1lh 4/13.",
				"Lestár tér 22./B",
				"Széchényi utca 12.",
				"Dob utca 75-81.",
				"Béke sugárút 38.",
				"Siha köz 11.",
				"Siha köz 10.",
				"Siha köz 1."]
			
		@invalid_street_addresses = [
			"Batthyány",
			"Lestár tér",
			"Széchényi utca 12",
			"Dob utca 11-."]
	end
		

	test "empty address is invalid" do
		address = Address.new
		assert !address.valid?
		assert address.errors.invalid?(:name)
		assert address.errors.invalid?(:city)
		assert address.errors.invalid?(:street)
		assert address.errors.invalid?(:zipcode)
	end
	
  test "zipcode must be 4 character long" do
		address = addresses(:my_address)
		
		# invalid test datas
		[0001,0,1,999,10000,10001].each do |zipcode|
			address.zipcode = zipcode
			assert !address.valid?, "Tested with #{zipcode}"
			assert address.errors.invalid?(:zipcode)
			assert_equal I18n.translate('activerecord.errors.models.address.attributes.zipcode.invalid',:count => 999), address.errors.on(:zipcode), "Errors was:#{address.errors.full_messages}"
		end
		
		# valid test datas
		[1000,1001,9999].each do |zipcode|
			address.zipcode = zipcode
			assert address.valid?, address.errors.full_messages
			assert !address.errors.invalid?(:zipcode), address.errors.on(:zipcode)
		end
  end

	test "street address match format" do
		address = addresses(:my_address)
		@valid_street_addresses.each do |street|
			address.street = street
			assert address.valid?, "Failed with:#{street}"
		end
	end
	
	test "street address dont match format" do
		address = addresses(:my_address)
		@invalid_street_addresses.each do |street|
			address.street = street
			assert !address.valid?, "Passed with:#{street}"
		end
	end
	
	test "store telephone numbers in plain digits" do
		address = addresses(:my_address)
		@valid_telephone_numbers.each do |tel|
			address.tel = tel
			address.valid? # after valid? we have to get back just plain numbers
			assert_equal @expected_number, address.tel
		end
	end
	
	test "accept various telephone numbers" do
		address = addresses(:my_address)
		@valid_telephone_numbers.each do |tel|
			address.tel = tel
			address.valid?
			assert address.valid?, "Failed with: #{address.tel}, #{address.errors.full_messages}"
		end
	end
	
	test "dont accept exact telephone numbers" do
		address = addresses(:my_address)
		@invalid_telephone_numbers.each do |tel|
			address.tel = tel
			assert !address.valid?, "Passed with:#{tel}"
			assert_equal I18n.translate('activerecord.errors.models.address.attributes.tel.invalid'), address.errors.on(:tel)
		end
	end
	
	test "accepted email addresses" do
		address = addresses(:my_address)
		@valid_email_addresses.each do |email|
			address.email = email
			assert address.valid?, "Failed with:#{email}, #{address.errors.full_messages}"
		end
	end
	
	test "invalid email addresses" do
		address = addresses(:my_address)
		@invalid_email_addresses.each do |email|
			address.email = email
			assert !address.valid?, "Passed with:#{email}"
			assert_equal I18n.translate('activerecord.errors.messages.invalid'), address.errors.on(:email)
		end
	end
end
