require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "create company" do
    company = Company.new
    assert company.save!
  end
  
  test "delete company" do
    company = Company.new
    company.save!
    company_delete = Company.find_by_id(company.id)
    assert company_delete.destroy
  end
  
end
