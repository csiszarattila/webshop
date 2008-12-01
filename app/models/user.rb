class User < ActiveRecord::Base
	belongs_to :group, :class_name => "UserGroup"
	
	validates_presence_of :username, :password
	validates_uniqueness_of :username
	
	# A felhasználónév nem tartalmazhat ékezetes karaktert sem szüntet
	validates_format_of :username, :with => /\A[_0-9a-zA-Z]+\Z/
	
	# Létrehozáskor legyen jelszó megerősítés
	validates_confirmation_of :password
	
	attr_reader :password
	# +password+ is a virtual attribute for setting passwords easily.
	# Its generates and add +salt+ and +hashed password+ to model's object.
	# 
	# A +password+ egy virtuális attribútum, egyszerű jelszó hozzáadáshoz.
	# Legenerálja és hozzá is adja a +salt+-ot és a +hashed_password+-öt a modell-objektumhoz.
  def password=(password)
    @password = password
    self.salt = generate_salt()
    self.hashed_password = User.encrypt_password(password,self.salt)
  end

	# Beállít egy új, véletlen [a-zA-Z0-9] karakterekből generált jelszót
	def random_password(length=6)
		pattern = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
		self.password = length.times.collect { pattern[rand(pattern.size)] }.to_s
	end

	# Matched users and then password against stored ones.
	# Return user only if it's match and password is correct otherwise return nil.
	# 
	# Kikeresi a felhasználót majd összehasonlítja a jelszavát az adatbázisban lévővel.
	# Egyezés esetén egy +User+ objektummal tér vissza, máskülönben nil értékkel.
  def self.authenticate(username, password)
    user = find_by_username(username)
    unless user.nil?
      if user.hashed_password != encrypt_password(password,user.salt)
        user = nil
      end
    end
    user
  end

	def self.create_a_customer(user)
		user.group = UserGroup.find_by_name("customer")
		user.save()
		Customer.create(:user => user)
		user
	end

  private
	# Generate a random +salt+
	# 
	# Véletlen +salt+ generálása
  def generate_salt
    self.object_id.to_s + rand().to_s
  end
	
	# SHA1 encrypt a password with a given salt
	# 
	# Jelszó kódolása SHA1 kódra egy megadott salt-tal
  def self.encrypt_password(password,salt)
    string_to_hash = password + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
end
