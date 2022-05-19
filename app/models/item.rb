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

  def self.name_search(keyword)
    keyword = '%'.concat(keyword.downcase).concat('%')
    Item.where('lower (items.name) like ?', keyword).order(:name).limit(1)
  end

  def self.min_price_search(num)
    Item.where('unit_price >= ?', num).order(:name)
  end

  def self.max_price_search(num)
    Item.where('unit_price <= ?', num).order(:name)
  end

  def self.price_range_search(num_1, num_2)
    Item.where('unit_price between ? and ?', num_1, num_2).order(:name)
  end
end
