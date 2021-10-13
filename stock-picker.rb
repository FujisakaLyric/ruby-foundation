def stock_picker(stock_prices)
    stock_hash = Hash.new
    stock_prices.length.times do |day|
        (day + 1).upto(stock_prices.length - 1) do |next_day|
            stock_hash[[day, next_day]] = stock_prices[next_day] - stock_prices[day]
        end
    end

    stock_hash.reduce([0,1]) do |best_profit, (dates, profit)|
        best_profit = dates if stock_hash[best_profit] < stock_hash[dates]
        best_profit
    end
end