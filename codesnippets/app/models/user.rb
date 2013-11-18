class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :snippets

  validates :username, 
    presence:            true, 
    uniqueness:          { case_sensitive: false },
    length:              { in: 4..20, 
                           too_long: "Your username must be under 20 characters", 
                           too_short: "Your username must be at least 4 characters"},
    format:              { with: /\A(?=.*[a-z])[a-z\d]+\Z/i, message: "Only letters and numbers are allowed in your username. Make sure to include at least one letter."}               

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
