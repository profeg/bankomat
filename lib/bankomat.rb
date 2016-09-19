class Bankomat
    def initialize
      @cash_box = {
        1 => 10,
        2 => 10,
        5 => 10,
        10 => 10,
        25 => 10,
        50 => 10
      }
      @coin_nominals = @cash_box.keys.sort{  |x,y| y <=> x }
    end
    
    def get_cash_box
      @cash_box
    end

    def add_one_coin coin
      @cash_box[coin] += 1
    end

    def add_ten_coins coin
      @cash_box[coin] += 10
    end

    def total_cash
      total_cash = 0
      @cash_box.each{ |key,value| total_cash += key * value }
      total_cash
    end
    
    def coin_present? coin
      @cash_box[coin] > 0
    end
    
    def get_coin_off coin
      @cash_box[coin] -= 1
    end
    
    def next_coin_nominal( coin=0 )
      @coin_nominals[coin]
    end
    
    def get_coins_set sum
      return "Not enought money in cash_box" if sum > total_cash
      coins_set = Array.new 
      coin = 0
      
      begin
        current_coin_nominal = next_coin_nominal(coin)
        return "Cant give requested sum" if current_coin_nominal.nil?
        rest = sum - current_coin_nominal
        if rest >= 0 && coin_present?(current_coin_nominal)
          coins_set << current_coin_nominal
          get_coin_off current_coin_nominal
          sum = rest
        else
          coin += 1
        end
      end while sum > 0
      coins_set
    end
    
  end