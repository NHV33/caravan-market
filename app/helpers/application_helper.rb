module ApplicationHelper
  def format_price(price)
    number_with_delimiter(price, delimiter: ',')
  end
end
