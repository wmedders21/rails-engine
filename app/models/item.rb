class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :merchant_id
  validates_presence_of :unit_price
  validates_numericality_of :unit_price
end
