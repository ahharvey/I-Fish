require 'rails_helper'

RSpec.describe Importers::CreateVessels do

  let(:company)     { create :company }
#  let!(:fish1)     { create :fish, code: 'SKJ' }
#  let!(:fish2)     { create :fish, code: 'YFT' }
#  let!(:fish3)     { create :fish, code: 'BET' }
#  let!(:fish4)     { create :fish, code: 'KAW' }
#  let!(:wpp1)        { create :wpp, name: '715' }
#  let!(:wpp2)        { create :wpp, name: '716' }
#  let!(:port1)       { create :port, name: 'Bitung' }
#  let!(:port2)       { create :port, name: 'Ambon' }

	context 'with valid import file' do

    let(:importer)	{
      create :importer,
        label: 'vessels',
        parent: company,
        file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'valid_vessels.xlsx'))
    }

		it 'creates the record, activity and version' do
			rows = Importers::CreateVessels.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call

      expect(Vessel.all.size).to eq 2
      expect(Vessel.first.attributes).to include(
        {
          "ap2hi_ref" => "1234567890",
          "capacity" => 300,
          "captain" => "John",
          "company_id" => importer.parent_id,
          "crew" => 2,
          "flag_state" => "United Kingdom",
          "flag_state_changed" => true,
          "hooks" => 20,
          "length" => 23,
          "machine_type" => "inboard",
          "material_type" => "wood",
          "name" => "Vessel A",
          "name_changed" => true,
          "owner" => "Fred",
          "port" => "Ambon",
          "radio" => true,
          "sipi_expiry" => Date.new(2015,1,1),
          "sipi_number" => "123456789",
          "siup_number" => "123456789",
          "tonnage" => 25,
          "tracker" => true,
          "vms" => true,
          "year_built" => "1998"
        }
      )
      expect(Vessel.last.attributes).to include(
        {
          "ap2hi_ref" => "abcdefgh",
          "capacity" => 300,
          "captain" => "John",
          "company_id" => importer.parent_id,
          "crew" => 20,
          "flag_state" => "Indonesia",
          "flag_state_changed" => true,
          "hooks" => 10,
          "length" => 300,
          "machine_type" => "inboard",
          "material_type" => "wood",
          "name" => "Vessel B",
          "name_changed" => true,
          "owner" => "Fred",
          "port" => "Ambon",
          "radio" => true,
          "sipi_expiry" => Date.new(2015,3,3),
          "sipi_number" => "123456789",
          "siup_number" => "123456789",
          "tonnage" => 600,
          "tracker" => true,
          "vms" => true,
          "year_built" => "2010",
        }
      )

      expect(Activity.all.size).to eq 2
      expect(Activity.first.attributes).to include(
        {
          "action" => 'create',
          "trackable_id" => Vessel.last.id,
          "trackable_type" => 'Vessel',
          "ownable_id" => importer.imported_by_id,
          "ownable_type" => 'Admin'
        }
      )
      expect(Activity.last.attributes).to include(
        {
          "action" => 'create',
          "trackable_id" => Vessel.first.id,
          "trackable_type" => 'Vessel',
          "ownable_id" => importer.imported_by_id,
          "ownable_type" => 'Admin'
        }
      )

      #expect(PaperTrail::Version.all.size).to eq 2
      #expect(BaitLoading.last.versions.last.whodunnit).to eq "Admin:#{importer.imported_by_id}"

		end
		it 'imported returns true' do
			expect( Importers::CreateVessels.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.imported
      ).to eq true
		end
    it 'improted_rows returns the rows' do
			expect( Importers::CreateVessels.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.imported_rows
      ).to match_array( Vessel.all )
		end
    it 'returns no errors' do
			expect( Importers::CreateVessels.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.errors.messages
      ).to match_array( [] )
		end
	end

  context 'with invalid import file' do
    let(:importer)	{
      create :importer,
        label: 'vessels',
        parent: company,
        file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'invalid_vessels.xlsx'))
    }
    it 'does not create the record, activity and version' do
      Importers::CreateVessels.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call
      expect(Vessel.all.size).to eq 0
      expect(Activity.all.size).to eq 0
      #expect(PaperTrail::Version.all.size).to eq 0
    end
    it 'imported returns false' do
			expect( Importers::CreateVessels.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.imported
      ).to eq false
		end
    it 'returns the errors' do
			expect( Importers::CreateVessels.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.errors.messages[:base]
      ).to eq(
        [
          "Row 2: AP2HI UVI can't be blank",
          "Row 3: AP2HI UVI can't be blank"
        ]
      )
		end
  end
end
