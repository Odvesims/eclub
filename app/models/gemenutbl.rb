class Gemenutbl < ActiveRecord::Base
  default_scope order: 'menu_item'
  attr_accessible :menu_cod, :menu_item, :menu_descr, :menu_controller, :item_orden, :item_type
  self.table_name = 'gemenu_tbl'
end