class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :recoverable, :rememberable, :validatable, 
         :confirmable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  has_secure_password
  validates_uniqueness_of :email
  validates :email, presence: true
  #validates :name, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  # Delete old users, who haven't logged in the last 2 years (2 minutes for demo purpose)
  def self.delete_old_users
    where("is_admin=false").where("updated_at < '#{Time.now - 2.minutes}'").delete_all
  end
    has_secure_password
    # Modified for password reset functionality
    attr_accessor :reset_token
    before_save   :downcase_email

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token= SecureRandom.urlsafe_base64
    self.reset_sent_at=Time.zone.now
    save!
  end
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  ## omniauth methods
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.auth_data"] && session["devise.auth_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    exist_user = where(:provider => auth.provider, :uid => auth.uid).first
    # check for email also incase the user is signed up in normal
    exist_user = exist_user ? exist_user : where(:email => auth.info.email).first
    if exist_user
      return exist_user
    end
    
    user = User.new
    user.email = auth.info.email
    # user.password_digest = Devise.friendly_token[0,20]
    user.password_digest = Devise.friendly_token[0,20]
    user.password = Devise.friendly_token[0,20]
    user.uid = auth.uid
    user.name = auth.info.name ? auth.info.name : auth.info.email   # assuming the user model has a name
    user.provider = auth.provider
    # user.save
    return user
	end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

end
