require 'rails_helper'
require 'user'

RSpec.describe User, type: :model do
   describe 'Validations' do

    context "All fields filled out correctly" do
      it "Creates user successfully" do
        @user = User.new
        @user.name = "John"
        @user.email = "example@gmail.com"
        @user.password = "password123"
        @user.password_confirmation = "password123"
        @user.save
        expect(@user.errors.full_messages).to match_array([])
      end
    end

    context "Password and confirmation do not match" do
      it "throws error" do
        @user = User.new
        @user.name = "John"
        @user.email = "example@gmail.com"
        @user.password = "password123"
        @user.password_confirmation = "password456"
        @user.save
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    context "No password or confirmation" do
      it "throws error" do
        @user = User.new
        @user.name = "John"
        @user.email = "example@gmail.com"
        @user.password = nil
        @user.password_confirmation = nil
        @user.save
        expect(@user.errors.full_messages).not_to be_empty
      end
    end

    context "Email is duplicated" do
      it "throws error" do
        @user1 = User.new
        @user1.name = "John"
        @user1.email = "example@example.com"
        @user1.password = "password123"
        @user1.password_confirmation = "password123"
        @user1.save

        @user2 = User.new
        @user2.name = "Oliver"
        @user2.email = "example@example.com"
        @user2.password = "testing123"
        @user2.password_confirmation = "testing123"
        @user2.save
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
    end

    context "No name" do
      it "throws error" do
        @user = User.new
        @user.name = nil
        @user.email = "example@gmail.com"
        @user.password = "examplepassword123"
        @user.password_confirmation = "examplepassword123"
        @user.save
        expect(@user.errors.full_messages).not_to be_empty
      end
    end

    context "No email" do
      it "throws error" do
        @user = User.new
        @user.name = "Jonathan"
        @user.email = nil
        @user.password = "examplepassword"
        @user.password_confirmation = "examplepassword"
        @user.save
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
    end

    context "Password less than 3 characters" do
      it "throws error" do
        @user = User.new
        @user.name = "Bob"
        @user.email = "bob@example.com"
        @user.password = "12"
        @user.password_confirmation = "12"
        @user.save
        expect(@user.errors.full_messages).to include("Password must be a minimum of 3 characters long")
      end
    end

    
  end

  describe '.authenticate_with_credentials' do
    context "Given correct email and password" do
      it "successfully authenticates" do
        @user = User.new
        @user.name = "Yusuf"
        @user.email = "example@example.com"
        @user.password = "password123"
        @user.password_confirmation = "password123"
        @user.save
        expect(@user.authenticate_with_credentials(@user.email, @user.password)).to match(@user)
      end
    end

    context "Given correct email and incorrect password" do
      it "returns nil" do
        @user = User.new
        @user.name = "Yusuf"
        @user.email = "example@example.com"
        @user.password = "password123"
        @user.password_confirmation = "password123"
        @user.save
        expect(@user.authenticate_with_credentials(@user.email, "12345")).to be_nil
      end
    end

    context "Given incorrect email" do
      it "returns nil" do
        @user = User.new
        @user.name = "Yusuf"
        @user.email = "example@example.com"
        @user.password = "password123"
        @user.password_confirmation = "password123"
        @user.save
        expect(@user.authenticate_with_credentials("wrong@email.com", @user.password)).to be_nil
      end
    end

    context "Given correct email (with spaces) and password" do
      it "successfully authenticates" do
        @user = User.new
        @user.name = "Yusuf"
        @user.email = "example@example.com"
        @user.password = "password123"
        @user.password_confirmation = "password123"
        @user.save
        expect(@user.authenticate_with_credentials(" example@example.com ", @user.password)).to match(@user)
      end
    end

    context "Given correct email (with incorrect casing) and password" do
      it "successfully authenticates" do
        @user = User.new
        @user.name = "Yusuf"
        @user.email = "example@example.com"
        @user.password = "password123"
        @user.password_confirmation = "password123"
        @user.save
        expect(@user.authenticate_with_credentials("ExaMple@example.com", @user.password)).to match(@user)
      end
    end
  end

end
