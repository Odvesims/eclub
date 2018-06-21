class Pdfdefault < ActiveRecord::Base
	default_scope order: 'id'
	attr_accessible :camporee_id, :pdf_name, :headers_text, :fonts_sizes, :columns_widths
	self.table_name = "pdfs_defaults"  
end

