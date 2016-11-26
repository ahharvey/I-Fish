require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Staff Creates Unloading" do

  describe "with signed in staff" do
    let(:admin)     { create :admin, office: office }
    let(:office)    { create :office }
    let(:user)      { create :user }
    let(:vessel)    { create :vessel, company: company }
    let(:fishery)   { create :fishery }
    let(:company)   { create :company }
    let(:wpp)       { create :wpp }
    let(:port)      { create :port }
    let(:fish)      { create :fish }

    before :each do
      office.member_fisheries.push fishery
      company.member_fisheries.push fishery
      vessel
      port
      wpp
      fish
      
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit root_path
    end

    it "creates with valid data" do

      expect(page).to have_link fishery.name, href: fishery_path(fishery)
      click_link fishery.name
      expect(current_path).to eq fishery_path(fishery)

      expect(page).to have_link company.name, href: company_path(company)
      click_link company.name
      expect(current_path).to eq company_path(company)

      expect(page).to have_link vessel.ap2hi_ref, href: vessel_path(vessel)
      click_link vessel.ap2hi_ref
      expect(current_path).to eq vessel_path(vessel)


      expect(page).to have_link 'New Unloading Report', href: new_vessel_unloading_path(vessel)
      click_link 'New Unloading Report'
      expect(current_path).to eq new_vessel_unloading_path(vessel)


      select port.name, from: 'Port'
      select wpp.name,  from: 'WPP'
      fill_in 'Dep',  with: Date.yesterday
      fill_in 'Arr',  with: Date.today
      fill_in 'Fuel', with: 5
      fill_in 'Ice',  with: 5

      click_button 'Save'

      expect(page).to have_content 'Unloading was successfully created'
      expect(current_path).to eq unloading_path(Unloading.last)

      expect( page.all('table#unloading_catch_table tr').count ).to eq 1

      select fish.code, from: 'Species'
      fill_in 'Quantity',  with: 300
      click_button 'Save'

      expect( page.all('table#unloading_catch_table tr').count ).to eq 2
    end


#    it "raises error with empty data" do
#      click_link 'Report an Encounter'#

#      expect(current_path).to eq new_prerep_path#

#      click_button 'Next'#

#      expect(page).to have_content "Well, this is embarassing! Could you help us out by taking a look at the highlighted items."
#      within(".prerep_count") do
#        expect(page).to have_content "Manta countcan only be whole number between 0 and 999."
#      end
#      within(".prerep_formatted_date") do
#        expect(page).to have_content "is not a valid date"
#      end#

#      within(".prerep_divesite_id") do
#        expect(page).to have_content "can't be blank"
#      end
#    end#

#  end#

#  describe "with already created survey" do
#    let(:user)        { create :user }
#    let(:prerep)      { create :prerep, user: user }
#    let!(:shark)      { create :species, name: "Grey reef" }
#    let!(:ray)      { create :species, name: "Reef Manta" }
#    let!(:impact)     { create :impact, name: "Trash" }
#    before :each do
#      login_as user
#      visit prerep_path(prerep)
#    end
#    it "adds additional data and sightings", :js do
#      click_link "Add survey details, wildlife and impacts"
#      fill_in 'Time', with: '12:15'
#      fill_in 'Depth (m)', with: '16'
#      fill_in 'Water Temp (°C)', with: '25'
#      fill_in 'Group size', with: '2'
#      fill_in 'Boats', with: '7'
#      select 'Slight - able to hold position with little effort.', from: 'Current'
#      #check 'Just swimming'
#      find('label', text: 'Just swimming').trigger('click')#

#      select 'Grey reef', from: 'prerep_sightings_attributes_0_species_id'
#      fill_in :prerep_sightings_attributes_0_count, with: "2"
#      find('a', text: "Add A Sighting").trigger('click')
#      expect(page).to have_selector 'fieldset.fe', count: 2, wait: 20#

#      within all('fieldset.fe').last do
#        select 'Reef Manta', from: find('select.select2-species')[:id]
#        fill_in find('input.string')[:id], with: "4"
#      end#

#      #check 'Trash'
#      find('label', text: 'Trash').trigger('click')#

#      find('button', text: 'Next').trigger('click')#

#      expect(page).to have_content "Manta Survey at #{prerep.region.name}"
#      expect(current_path).to eq prerep_path(prerep)
#      expect(page).to have_content '12:15'
#      expect(page).to have_content 'Depth: 16'
#      expect(page).to have_content 'Temperature: 25'
#      expect(page).to have_content 'Group size: 2'
#      expect(page).to have_content 'Boats: 7'
#      expect(page).to have_content 'Current: Slight - able to hold position with little effort.'#

#      expect(page).to have_selector "div.species_#{shark.id}"
#      expect(page).to have_selector "div.species_#{ray.id}"
#      expect(page).to have_selector "div.impact_#{impact.id}"#

#    end#

#  end#

#  describe 'sorts photos' do#
#

#    let(:user)        { create :user }
#    let(:prerep)      { create :prerep, user: user }
#    let!(:asset1)     { create :asset, prerep: prerep }
#    let!(:asset2)     { create :asset, prerep: prerep }
#    let!(:asset3)     { create :asset, prerep: prerep }
#    let!(:sighting1)  { create :sighting, species: shark, prerep: prerep }
#    let!(:sighting2)  { create :sighting, species: ray, prerep: prerep }
#    let!(:observation){ create :observation, impact: impact, prerep: prerep }
#    let(:sharks)      { create :family, name: 'Shark'}
#    let(:rays)        { create :family, name: 'Ray'}
#    let!(:shark)      { create :species, name: "Grey Reef", family: sharks }
#    let!(:ray)        { create :species, name: "Reef Manta", family: rays }
#    let!(:impact)     { create :impact, name: "Trash" }
#    let!(:manta1)      { create :manta, dots: '3', name: 'Manta Name', asset: asset1 }
#    let!(:manta2)      { create :manta, dots: '3', asset: asset2 }
#    before :each do
#      login_as user
#      visit prerep_path(prerep)
#    end
#    it 'sorts photos and shows describe page if mantas exist', :js do
#      find( 'a', text: 'Sort and classify survey photos').click
#      expect(page).to have_content "Sort Organize your ID photos"#

#      3.times do |i|
#        item = all('div.unassigned__item').first
#        target = all('div.drop-area__new').first
#        item.drag_to(target)#

#        expect(page).to have_selector 'div.drop-area__item[data-dropzone="add"]', count: i + 1
#      end#
#

#      find('a', text: 'Next').trigger('click')#

#      expect(page).to have_content "Classify Record the subject of each set of photos"
#      expect(current_path).to eq classify_prerep_encountered_mantas_path(prerep)#

#      within find('#encounter_0') do
#        find('label', text: 'Grey Reef Shark').trigger('click')
#      end#

#      within find('#encounter_1') do
#        find('label', text: 'Trash').trigger('click')
#      end#

#      within find('#encounter_2') do
#        find('label', text: 'Reef Manta Ray').trigger('click')
#      end#

#      click_link 'Next'#

#      expect(page).to have_content "Describe Add details about your Mantas"
#      expect(current_path).to eq edit_multiple_prerep_encountered_mantas_path(prerep)
#      expect(page).to have_selector ".section-divider", count: 1#

#      # click image maps and fill in details
#      all('rect.male', visible: false).first.trigger('click')
#      all('rect.chevron', visible: false).last.trigger('click')
#      all('rect.left_cephalic', visible: false).last.trigger('click')
#      fill_in "Dots", with: '3'
#      click_button 'Next'#

#      # check manta details are saved and only 1 manta displayed
#      expect(page).to have_content 'Encounters'
#      expect(page).to have_selector 'div.panel.encounter', count: 3
#      within first('div.panel.encounter') do
#        find('a.btn', text: 'Open').trigger('click')
#      end
#      expect(page).to have_selector "li.gender", text: "Male"
#      expect(page).to have_selector "li.colormorph", text: "Chevron"
#      expect(page).to have_selector "li.injuries", text: "Left cephalic"
#      expect(page).to have_selector "li.dots", text: "3"#
#

#      expect(page).to have_content 'MATCH'
#      expect(page).to have_content 'This individual has not been matched yet'
#      expect(page).to have_link "Help match this individual"
#      click_link "Help match this individual"#

#      within('#mantas_container') do
#        expect(page).to_not have_selector '.manta-selector'
#      end
#      within('#selected_manta_container') do
#        expect(page).to_not have_selector 'h4'
#      end#
#
#

#      within 'form#filter_form' do
#        select "", from: 'Colormorph'
#        select "", from: 'Gender'
#        unselect "Left cephalic", from: 'Has injuries'
#        select "", from: 'Recorded in'
#        fill_in 'Interbranchial Dots', with: ""
#        find("input[value='Filter']").trigger('click')
#      end#

#
#      within('#mantas_container') do#

#        expect(page).to have_selector 'a.manta-selector', count: 2, wait: 30
#        first('.manta-selector').trigger('click')
#      end#
#

#      within('#selected_manta_container') do
#        expect(page).to have_selector 'h4', text: 'Manta Name', wait: 30
#      end#
#
#

#      find("input[value='Match']").trigger('click')#

#      expect(page).to have_content 'Your match was successfully submitted.'
#      expect(current_path).to eq encountered_manta_path(EncounteredManta.first)#
#

#    end

#    it "creates prerep with all data" do
#      click_link 'prerep_new'
#      filescrl_in 'Manta count', with: 5
#      #fill_in 'prerep_date', with: Date.today
#      select_date Date.today, from: 'prerep_date'
#      #fill_in 'Time', with: '11:30'
#      fill_in 'Depth', with: 12
#      fill_in 'Water Temp', with: 25
#      fill_in 'Group size', with: 10
#      fill_in 'Boats', with: 10
#      fill_in 'Notes', with: "here are some notes"
#      select "No current", :from => 'Current'
#      #check('prerep_mantas_')
#      #check('Just swimming')
#      select Country.first.name, :from => 'Country'
#      select Region.first.name, :from => 'Region'
#      select Divesite.first.name, :from => 'Divesite'
#      click_button 'Next'
#      expect(page).to have_content 'upload'
#      attach_file('asset_file', File.join(Rails.root, 'spec', 'support', 'images', 'test_image.jpg'))
#      click_link 'Next'
#      expect(page).to have_selector '#unassigned_asset_container'
#      within( '#unassigned_asset_container' ) do
#  #      expect(page).to have_selector '.galleryimg, count: 3'
#     #   page.should have_selector( 'img', :count => 1)
#      end
#      expect(page).to have_css 'manta-info-fields'
#      within( '#edit_prerep_1' ) do
#  #      expect(page).to have_selector '.galleryimg, count: 3'
#        page.should have_selector( 'div[class=manta-info-fields]', :count => 2)
#      end
#      check('gender-toggle-male')
#      click_button 'Next'#

#    end

#    it "uploads from Dropbox"#

#    it "uploads from Facebook"#

#    it "uploads from Flickr"#

#    it "displays errors with out of range values"#

#    it "allows user to select injuries and errors"#

#    it "allows user to share to social"#

#    it "needs some assertions about checking injuries and markings"#

#    it "shows connect link on share page if social provider not connected"#

#    it "allows post to social if connected to social"

    it "creates a region and divesite if not recognized"

    it "tags operator"
    it "adds operator"
    it "tags guide"
    it "tags fb friend"
    it "displays sort photos button"
    it "displays encounters button"
  end


end
