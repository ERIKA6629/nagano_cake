class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_payment: 0, confirmed_payment: 1, is_producing: 2, prepareing_shipping: 3, confirmed_shipping: 4 }
  
  belongs_to :customer
  has_many :order_details
end
