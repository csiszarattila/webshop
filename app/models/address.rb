class Address < ActiveRecord::Base
	belongs_to :addressable, :polymorphic => true
	
	validates_presence_of :name, :city, :street, :zipcode
	# Ir. 1000 és 10000 közé essen
	validates_numericality_of :zipcode, :greater_than => 999, :less_than => 10000
	# Utca mezo formája : utcanev típus hazszam.[/A|B...] + tovabbiak([emelet|lakas]..stb)
	validates_format_of :street, :with => /\A\w+\s+\w+\s+\d{1,4}([-]\d{1,4})?\.[\/]?[A-Z]?.*\Z/
end
