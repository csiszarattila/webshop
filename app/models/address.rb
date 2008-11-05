class Address < ActiveRecord::Base
	belongs_to :addressable, :polymorphic => true
	
	validates_presence_of :name, :city, :street, :zipcode, :tel, :email
	# Irányítószámok: 4 számjegyűnek kell lenniük - 1000-9999
	validates_numericality_of :zipcode, :greater_than => 999, :less_than => 10000, :message => I18n.translate('activerecord.errors.models.address.attributes.zipcode.invalid')
	# Utca mező formája: 
	# Utcanév Típus Házszám(1-9999)[-(1-9999)].(pont)[/(a-z)|(A-Z)] + egyeb pl.[emelet|lakas]
	validates_format_of :street, :with => /\A\w+\s+\w+\s+[1-9]\d{1,3}([-][1-9]\d{1,3})?\.[\/]?[A-Za-z]?.*\Z/
	
	#-- 
	# Here tel numbers is validated after 
	# 'before_validation' callback is called(!).
	# So tel numbers here is just plain numbers.
	# 
	# A tel.szam itt már tisztán csak számjegyekből áll.
	# ++
	# 
	# Elfogadott telefonszám formátumok: 
	# * Mobil: 06(1-99)1xxxxxx 
	# * Vezetekes (1-99)-1xx-xxx
	validates_format_of :tel, :with => /\A[1-9]([1-9]\d{5}|[0-9][1-9]\d{5})|06[1-9][0-9][1-9]\d{6}\Z/
	
	validates_format_of :email, :with => /\A[a-zA-Z0-9._%+-]+@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,4}\Z/ 
	
	def before_validation
		# Strip every character from tel numbers
		# so 06-30/623-4562 became 06306234562
		# A telefonszámokat tisztán számsorként tároljuk
		self.tel = strip_everything_but_digits(tel) if attribute_present?("tel")
	end

	def strip_everything_but_digits(string)
		string.gsub(/[^0-9]/, "")
	end
end
