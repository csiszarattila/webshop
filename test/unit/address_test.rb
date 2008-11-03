require 'test_helper'

class AddressTest < ActiveSupport::TestCase

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
			#assert_equal I18n.translate('activerecord.errors.messages.greater_than',:count => 999), address.errors.on(:zipcode), "Errors was:#{address.errors.full_messages}"
		end
		
		# valid test datas
		[1000,1001,9999].each do |zipcode|
			address.zipcode = zipcode
			assert address.valid?, address.errors.full_messages
			assert !address.errors.invalid?(:zipcode), address.errors.on(:zipcode)
		end
  end

	test "street address match format" do
		street_addresses = [
			"Batthyány út 99. 1lh 4/13.",
			"Lestár tér 22./B",
			"Széchényi utca 12.",
			"Dob utca 75-81.",
			"Béke sugárút 38."]
			
		address = addresses(:my_address)
		street_addresses.each do |street|
			address.street = street
			assert address.valid?, "Tested with:#{street}"
		end
	end
	
	test "street address dont match format" do
		street_addresses = [
			"Batthyány",
			"Lestár tér",
			"Széchényi utca 12",
			"Dob utca 11-."]
			
		address = addresses(:my_address)
		street_addresses.each do |street|
			address.street = street
			assert !address.valid?, "Tested with:#{street}"
		end
	end
end
