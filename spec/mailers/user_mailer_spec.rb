require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
 describe "password_reset" do
  
    it "password reset call" do
        @user = FactoryBot.create(:user, id: "1")
        # allow(ApplicationMailer).to receive(:mail).and_return("")
        mail = described_class.password_reset(@user).deliver_now
        expect(mail.to).to eq([@user.email])
    end
 end

end
