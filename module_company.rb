# frozen_string_literal: true

module Company
  attr_accessor :name_company

  protected

  def validate!
    raise 'Empty company name' if name_company.nil? || name_company == ''
  end
end
