class Vgemenuroute < ActiveRecord::Base
  default_scope order: 'menu_item'
  attr_accessor :menu_cod, :menu_item, :menu_descr, :menu_controller, :item_order, :item_type,
                  :menu_level, :icon, :opc_item, :opc_controller, :opc_descr
  self.table_name = 'v_gemenu_route'
end