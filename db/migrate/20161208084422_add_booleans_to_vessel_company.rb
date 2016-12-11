class AddBooleansToVesselCompany < ActiveRecord::Migration[5.0]
  def change
    add_column    :vessels,   :marked,       :boolean, default: false
    add_column    :vessels,   :member,       :boolean, default: false
    add_column    :vessels,   :cert_type,    :string,  default: 'none'
    add_reference :vessels,   :fishery,      index: true

    add_column    :companies, :processing, :boolean, default: false
    add_column    :companies, :harvest,    :boolean, default: false

  end
end
