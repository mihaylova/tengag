require 'spec_helper'

describe User do
  it { should allow_mass_assignment_of(:email) }

  it { should allow_mass_assignment_of(:password) }

  it { should allow_mass_assignment_of(:password_confirmation) }

  it { should allow_mass_assignment_of(:remember_me) }

  it { should allow_mass_assignment_of(:username) }

  it { should respond_to(:login) }
  it { should respond_to(:login=) }
  it { should allow_mass_assignment_of(:login) }

  context 'login' do
    before do
      @user = FactoryGirl.create :user
    end

    its "can find user by username" do
      user = User.find_first_by_auth_conditions({login: @user.username})

      user.should eq @user
    end

    its "can find user by email" do
      user = User.find_first_by_auth_conditions({login: @user.email})

      user.should eq @user
    end
  end

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  it { should have_many(:posts).dependent(:destroy) }

  
  
end
