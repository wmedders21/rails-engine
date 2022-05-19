class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  def self.name_search(keyword)
    keyword = '%'.concat(keyword.downcase).concat('%')
    Merchant.where('lower (name) like ?', keyword).order(:name).limit(1)
  end
end
