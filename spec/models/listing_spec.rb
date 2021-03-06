require 'rails_helper'

RSpec.describe Listing, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let(:neighborhood) { FactoryGirl.create(:neighborhood) }
  before do
    @listing = Listing.new(street_address: 'Some address', available_date: Date::tomorrow, landlord: 'some name',
                           neighborhood: neighborhood, zip_code: '1')
    puts @listing.headline
  end

  subject { @listing }

  it { should respond_to(:agent_id) }
  it { should respond_to(:main_photo) }
  it { should respond_to(:street_address) }
  it { should respond_to(:zip_code) }
  it { should respond_to(:price) }
  it { should respond_to(:size) }
  it { should respond_to(:description) }

  it { should respond_to(:yard) }
  it { should respond_to(:patio) }
  it { should respond_to(:fake_address) }
  it { should respond_to(:export_to_streeteasy) }
  it { should respond_to(:export_to_myastoria) }
  it { should respond_to(:export_to_nakedapartments) }
  it { should respond_to :title }
  it { should respond_to :headline }
  it { should respond_to :access }
  it { should respond_to :fake_city_id }
  it { should respond_to :fake_city }
  it { should respond_to :fake_unit_no }
  it { should respond_to :hide_address_for_nakedapartments }
  it { should respond_to :exported_to_nakedapartments }
  it { should respond_to :exported_to_streeteasy }
  it { should respond_to :exported_to_myastoria }
  it { should respond_to :featured }

  it { should respond_to :type_of_space_id }
  it { should respond_to :dividable }
  it { should respond_to :taxes_included }
  it { should respond_to :taxes_amount }
  it { should respond_to :charges }
  it { should respond_to :maintenance }

  it { should respond_to :start_date }
  it { should respond_to :expiration_date }
  it { should respond_to :commission }
  it { should respond_to :mls_no }
  it { should respond_to :lot_size }
  it { should respond_to :building_size }
  it { should respond_to :interior_square_feet }
  it { should respond_to :tax_abatement }
  it { should respond_to :tax_abatement_end_date }
  it { should respond_to :action_user_id }
  it { should respond_to :action_user }

  it { should be_valid }

  describe 'when address is blank' do
    before { @listing.street_address = '' }
    it { should_not be_valid }
  end

  describe 'when zip code is blank' do
    before { @listing.zip_code = ' ' }
    it { should_not be_valid }
  end


  describe 'when price is blank' do
    before { @listing.price = nil }
    it { should be_valid }
  end

  describe 'when price is zero' do
    before { @listing.price = 0.0 }
    it { should_not be_valid }
  end

  describe 'when price is negative' do
    before { @listing.price = -1.0 }
    it { should_not be_valid }
  end

  describe 'when full_baths_no is blank' do
    before { @listing.full_baths_no = nil }
    it { should be_valid }
  end

  describe 'when full_baths_no is zero' do
    before { @listing.full_baths_no = 0 }
    it { should_not be_valid }
  end

  describe 'when full_baths_no is negative' do
    before { @listing.full_baths_no = -1 }
    it { should_not be_valid }
  end
  describe 'when full_baths_no is not integer' do
    before { @listing.full_baths_no = 1.5 }
    it { should_not be_valid }
  end
  describe 'when half_baths_no is blank' do
    before { @listing.half_baths_no = nil }
    it { should be_valid }
  end

  describe 'when half_baths_no is zero' do
    before { @listing.half_baths_no = 0 }
    it { should_not be_valid }
  end

  describe 'when half_baths_no is negative' do
    before { @listing.half_baths_no = -1 }
    it { should_not be_valid }
  end
  describe 'when half_baths_no is not integer' do
    before { @listing.half_baths_no = 1.5 }
    it { should_not be_valid }
  end

  describe 'when available_date is not present' do
    before { @listing.available_date = nil }
    context 'rentals' do
      it 'is not valid' do
        @listing.listing_type_id= ListingType.create(name: 'Rental').id
        expect(@listing).to_not be_valid
      end
    end

    context 'sales' do
      it 'is valid' do
        @listing.listing_type_id= ListingType.create(name: 'Sale').id
        expect(@listing).to be_valid
      end
    end
  end
  describe 'when landlord is blank' do
    before { @listing.landlord = ' ' }
    it { should_not be_valid }
  end

  describe 'when title is blank' do
    it 'gives a neighborhood as a headline' do
      @listing.title = ' '
      expect(@listing.headline).to eq @listing.neighborhood.name
    end
  end

  describe 'when title is not blank' do
    it 'gives a title as a headline' do
      @listing.title = 'some'
      expect(@listing.headline).to eq @listing.title
    end
  end

  # describe 'emails' do
  #   before do
  #     @listing.save
  #     ActionMailer::Base.delivery_method = :test
  #   end
  #   it 'sends an email' do
  #     expect { subject.send_created }.to change(ActionMailer::Base.deliveries, :count).by(1)
  #   end
  # end

end
