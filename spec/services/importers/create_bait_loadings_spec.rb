require 'rails_helper'

RSpec.describe Importers::CreateBaitLoadings do

  let(:vessel)    { create :vessel }
  let!(:bait1)     { create :bait, code: 'TER' }
  let!(:bait2)     { create :bait, code: 'TEM' }
  let!(:bait3)     { create :bait, code: 'MAE' }
  let!(:bait4)     { create :bait, code: 'LAY' }

	context 'with valid import file' do

    let(:importer)	{
      create :importer,
        label: 'bait_loadings',
        parent: vessel,
        file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'valid_bait_loadings.xlsx'))
    }

		it 'creates the record, activity and version', :focus do

			Importers::CreateBaitLoadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call
      expect(BaitLoading.all.size).to eq 2
      expect(BaitLoading.first.attributes).to include(
        {
          "quantity" => 5,
          "date" => Date.new(2015,1,1),
          "price" => 100,
          "method_type" => 'bagan',
          "bait_id" => bait1.id,
          "secondary_bait_id" => bait3.id
        }
      )
      expect(BaitLoading.last.attributes).to include(
        {
          "quantity" => 10,
          "date" => Date.new(2015,2,2),
          "price" => 300,
          "method_type" => 'bouke',
          "bait_id" => bait2.id,
          "secondary_bait_id" => bait4.id
        }
      )

      expect(Activity.all.size).to eq 2
      expect(Activity.first.attributes).to include(
        {
          "action" => 'create',
          "trackable_id" => BaitLoading.last.id,
          "trackable_type" => 'BaitLoading',
          "ownable_id" => importer.imported_by_id,
          "ownable_type" => 'Admin'
        }
      )
      expect(Activity.last.attributes).to include(
        {
          "action" => 'create',
          "trackable_id" => BaitLoading.first.id,
          "trackable_type" => 'BaitLoading',
          "ownable_id" => importer.imported_by_id,
          "ownable_type" => 'Admin'
        }
      )

      #expect(PaperTrail::Version.all.size).to eq 2
      #expect(BaitLoading.last.versions.last.whodunnit).to eq "Admin:#{importer.imported_by_id}"

		end
		it 'imported returns true' do
			expect( Importers::CreateBaitLoadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.imported
      ).to eq true
		end
    it 'improted_rows returns the rows' do
			expect( Importers::CreateBaitLoadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.imported_rows
      ).to match_array( BaitLoading.all )
		end
	end

  context 'with invalid import file' do
    let(:importer)	{
      create :importer,
        label: 'bait_loadings',
        parent: vessel,
        file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'invalid_bait_loadings.xlsx'))
    }
    it 'does not create the record, activity and version' do
      Importers::CreateBaitLoadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call
      expect(BaitLoading.all.size).to eq 0
      expect(Activity.all.size).to eq 0
      #expect(PaperTrail::Version.all.size).to eq 0
    end
    it 'imported returns false' do
			expect( Importers::CreateBaitLoadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.imported
      ).to eq false
		end
    it 'returns the errors' do
			expect( Importers::CreateBaitLoadings.new(
        file: importer.file,
        imported_by: importer.imported_by,
        parent: importer.parent
        ).call.errors.messages[:base].to_yaml
      ).to eq(
        [
          "Row 2: Bait can't be blank",
          "Row 2: Quantity (buckets) must be greater than or equal to 1",
          "Row 2: Catching method is not included in the list",
          "Row 3: Bait can't be blank",
          "Row 3: Quantity (buckets) must be greater than or equal to 1",
          "Row 3: Catching method is not included in the list"
        ].to_yaml
      )
		end
  end
end
