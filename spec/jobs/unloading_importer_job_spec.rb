require 'rails_helper'

RSpec.describe UnloadingImporterJob, type: :job do
	include ActiveJob::TestHelper


	subject(:job) { described_class.perform_later(importer.id) }

  let(:valid_attributes) {
    {
      vessel_id: vessel.id,
      bait_id: bait.id,
      quantity: 30
    }
  }

  let(:admin)					{ create :admin }
  let(:importer)      { create :importer, label: 'vessels', imported_by: admin, parent: company }
  let(:company )      { create :company }


  it 'add a job to the queue'do
  	expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end
  it 'adds a job with the correct params' do
  	expect { job }.to have_enqueued_job.with(importer.id)
  end
  it 'uses the correct queue' do
	  expect { job }.to have_enqueued_job.on_queue("default")
	end

  context 'with imported unloadings' do
  	let(:importer)	{ create :importer, label: 'unloadings', imported_by: admin, parent: company }
  	it 'calls the CreateUnloading sevice' do
			file = importer.file
#  		ins = Importers::CreateUnloadings.new( imported_by: importer.imported_by, parent: importer.parent  )
#      expect( Importers::CreateUnloadings ).to receive(:new).with(
#        file: file,
#				imported_by: importer.imported_by,
#				parent: importer.parent
#      ).and_return(ins)
      expect_any_instance_of(Importers::CreateUnloadings).to receive(:call)
	  	expect_any_instance_of(Importers::CreateBaitLoadings).to_not receive(:call)
      expect_any_instance_of(Importers::CreateVessels).to_not receive(:call)
	  	#UnloadingImporterJob.new.perform( importer.id )
      UnloadingImporterJob.perform_now( importer.id )
	  end
  end

  context 'with imported bait loadings' do
  	let(:importer)	{ create :importer, label: 'bait_loadings', imported_by: admin, parent: company }
  	it 'calls the CreateBaitLoading service' do
			file = importer.file
#  		ins = Importers::CreateBaitLoadings.new( file: file, imported_by: importer.imported_by, parent: importer.parent  )
#      expect( Importers::CreateBaitLoadings ).to receive(:new).with(
#        file: file,
#				imported_by: importer.imported_by,
#				parent: importer.parent
#      ) #.and_return(ins)
      expect_any_instance_of(Importers::CreateUnloadings).to_not receive(:call)
	  	expect_any_instance_of(Importers::CreateBaitLoadings).to receive(:call)
      expect_any_instance_of(Importers::CreateVessels).to_not receive(:call)
	  	#UnloadingImporterJob.new.perform( importer.id )
      UnloadingImporterJob.perform_now( importer.id )
	  end
  end

  context 'with imported vessels' do
  	let(:importer)	{ create :importer, label: 'vessels', imported_by: admin, parent: company }
  	it 'calls the CreateUnloading service' do
			file = importer.file
#  		ins = Importers::CreateVessels.new( imported_by: importer.imported_by, parent: importer.parent  )
#      expect( Importers::CreateVessels ).to receive(:new).with(
#        file: file,
#				imported_by: importer.imported_by,
#				parent: importer.parent
#      ).and_return(ins)
      expect_any_instance_of(Importers::CreateUnloadings).to_not receive(:call)
	  	expect_any_instance_of(Importers::CreateBaitLoadings).to_not receive(:call)
      expect_any_instance_of(Importers::CreateVessels).to receive(:call)
	  	#UnloadingImporterJob.new.perform( importer.id )
      UnloadingImporterJob.perform_now( importer.id )
	  end
  end

  it 'sends the mailers'
  it 'adds the Rails logger'
  it 'sets as approved/rejected'
end
