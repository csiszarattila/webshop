# desc "Explaining what the task does"
# task :zipcode_match do
#   # Task goes here
# end
namespace :db do
	namespace :zipcodes do
		desc "Irányítószámok betöltése az adatbázisba"
		task :load => [:environment] do
			ZipcodeMatch::import_from_csv()
		end
		desc "Irányítószámok törlése az adatbázisból"
		task :delete => [:environment] do
			ZipcodeMatch::delete_from_db()
		end
	end
end