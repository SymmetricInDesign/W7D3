class User < ApplicationRecord

    validates :email, presence: true, uniqueness: true
    validates :password_digest, :session_token, presence: true
    validates :password, allow_nil: true, length: {minimum: 6}
    
    after_initialize :ensure_session_token
    attr_reader :password

    def self.find_by_credentials(email, password)
        # password
        user = User.find_by(email: email)
        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

    def is_password?(password)
        BCrypt::Password.new(password_digest).is_password?(password)
    end

    def ensure_session_token
        self.session_token ||= self.generate_session_token
    end

    def generate_session_token
        self.session_token = SecureRandom::urlsafe_base64
    end



    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)

    end

    





end