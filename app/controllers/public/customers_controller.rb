class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    find_current_customer
  end
  
  def edit
    find_current_customer
  end
  
  def update
    find_current_customer
    @customer.update(customer_params)
    redirect_to my_page_path
  end
  
  def withdraw
    find_current_customer
    @customer.update(is_active: false)
    reset_session
    redirect_to new_customer_registration_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_active)
  end
  
  def find_current_customer
    @customer = Customer.find(current_customer.id)
  end
  
end
