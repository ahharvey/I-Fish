require 'rails_helper'

RSpec.describe Importers::CreateUnloadings do

  let(:vessel)     { create :vessel }
  let!(:fish1)     { create :fish, code: 'SKJ' }
  let!(:fish2)     { create :fish, code: 'YFT' }
  let!(:fish3)     { create :fish, code: 'BET' }
  let!(:fish4)     { create :fish, code: 'KAW' }
  let!(:wpp1)        { create :wpp, name: '715' }
  let!(:wpp2)        { create :wpp, name: '716' }
  let!(:port1)       { create :port, name: 'Bitung' }
  let!(:port2)       { create :port, name: 'Ambon' }

	context 'with valid import file' do

    let(:importer)	{
      create :importer,
        label: 'unloadings',
        parent: vessel,
        file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'valid_unloadings.xlsx'))
    }

		it 'creates the record, activity and version' do
			Importers::CreateUnloadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call
      expect(Unloading.all.size).to eq 2
      expect(Unloading.first.attributes).to include(
        {
          "time_out" => Time.new(2015,1,1,10,00,00, "+00:00"),
          "time_in" => Time.new(2015,1,2,00,00,00, "+00:00"),
          "etp" => true,
          "fuel" => 100,
          "ice" => 20,
          "port_id" => port1.id,
          "wpp_id" => wpp1.id
        }
      )
      expect(Unloading.last.attributes).to include(
        {
          "time_out" => Time.new(2015,2,1,00,00,00, "+00:00"),
          "time_in" => Time.new(2015,2,2,00,00,00, "+00:00"),
          "etp" => false,
          "fuel" => 300,
          "ice" => 300,
          "port_id" => port2.id,
          "wpp_id" => wpp2.id
        }
      )
      expect(Unloading.first.unloading_catches.size).to eq 4
      expect(Unloading.first.unloading_catches.pluck(:fish_id, :quantity)).to match_array(
        [
          [fish1.id, 20],
          [fish2.id, 30],
          [fish3.id, 40],
          [fish4.id, 50]
        ]
      )
      expect(Unloading.last.unloading_catches.size).to eq 3
      expect(Unloading.last.unloading_catches.pluck(:fish_id, :quantity)).to match_array(
        [
          [fish1.id, 200],
          [fish3.id, 400],
          [fish4.id, 500]
        ]
      )

      expect(Activity.all.size).to eq 2
      expect(Activity.first.attributes).to include(
        {
          "action" => 'create',
          "trackable_id" => Unloading.last.id,
          "trackable_type" => 'Unloading',
          "ownable_id" => importer.imported_by_id,
          "ownable_type" => 'Admin'
        }
      )
      expect(Activity.last.attributes).to include(
        {
          "action" => 'create',
          "trackable_id" => Unloading.first.id,
          "trackable_type" => 'Unloading',
          "ownable_id" => importer.imported_by_id,
          "ownable_type" => 'Admin'
        }
      )

      #expect(PaperTrail::Version.all.size).to eq 2
      #expect(BaitLoading.last.versions.last.whodunnit).to eq "Admin:#{importer.imported_by_id}"

		end
		it 'imported returns true' do
			expect( Importers::CreateUnloadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.imported
      ).to eq true
		end
    it 'improted_rows returns the rows' do
			expect( Importers::CreateUnloadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.imported_rows
      ).to match_array( Unloading.all )
		end
    it 'returns no errors' do
			expect( Importers::CreateUnloadings.new(
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
        label: 'unloadings',
        parent: vessel,
        file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'invalid_unloadings.xlsx'))
    }
    it 'does not create the record, activity and version' do
      Importers::CreateBaitLoadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call
      expect(Unloading.all.size).to eq 0
      expect(Activity.all.size).to eq 0
      #expect(PaperTrail::Version.all.size).to eq 0
    end
    it 'imported returns false' do
			expect( Importers::CreateUnloadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.imported
      ).to eq false
		end
    it 'returns the errors' do
			expect( Importers::CreateUnloadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.errors.messages[:base]
      ).to eq(
        [
          "Row 2: Unloading catches quantity is not a number",
          "Row 2: Port can't be blank",
          "Row 2: WPP can't be blank",
          "Row 2: Dep. is not a valid datetime",
          "Row 2: Arr. is not a valid datetime",
          "Row 3: Unloading catches quantity is not a number",
          "Row 3: Port can't be blank",
          "Row 3: WPP can't be blank",
          "Row 3: Dep. is not a valid datetime",
          "Row 3: Arr. is not a valid datetime"
        ]
      )
		end
  end
end
