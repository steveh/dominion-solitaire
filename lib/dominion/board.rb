module Dominion
  module Board
    DEFAULT_CARDS = [:copper, :silver, :gold, :estate, :duchy, :provence, :curse]
    DEFAULT_AMOUNT = 8
    AMOUNTS = {
      :copper => 60,
      :silver => 40,
      :gold   => 30
    }

    def board
      @board ||= begin
        (card_set & cards.keys).map {|x|
          card_array(x, AMOUNTS[x] || DEFAULT_AMOUNT)
        }
      end
    end

    def card_set
      DEFAULT_CARDS + randomize(cards.keys - DEFAULT_CARDS)[0..9]
    end

    def card(key)
      cards[key] || raise("No card #{key}")
    end

    def card_array(key, number)
      [card(key)] * number
    end
  end
end
