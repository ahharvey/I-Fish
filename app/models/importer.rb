class Importer < ActiveRecord::Base
	mount_uploader :file, ExcelFileUploader
end