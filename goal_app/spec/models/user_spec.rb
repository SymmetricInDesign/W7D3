require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build :user }

  # pending "add some examples to (or delete) #{__FILE__}"
  # let(:incomplete_user) {User.new(password: "catsfsdf", password_digest: "asdjhfbadjks", session_token: "aksjdbfakcdfasdfasdf")}
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }

  it { should validate_length_of(:password).is_at_least(6) }

  it { should allow_value(nil).for(:password) }

  #find_by_credentials returns the user given valid credentials, otherwise nil

  describe "User.find_by_credentials" do
    user = FactoryBot.build :user
  
    before { user.save! }
    it "should return a user if the credentials match" do
      expect(User.find_by_credentials(user.email, user.password)).to eq(user)
    end

    it "should return nil if the credentials don't match" do
      expect(User.find_by_credentials(user.email, "freddyyyy")).to eq(nil)
    end



  end

  

end
