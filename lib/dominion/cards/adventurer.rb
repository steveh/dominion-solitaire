Dominion::CARDS[:adventurer] = {
  :type        => :action,
  :cost        => 6,
  :description => 'Reveal until 2T revealed: T to hand, rest to discard',
  :behaviour   => lambda {|game, card|
    player = game.player
    revealed = []
    treasure = lambda { 
      revealed.select {|x| [*x[:type]].include?(:treasure) }
    }

    while treasure[].size < 2 && !(player[:deck] + player[:discard]).empty?
      revealed << game.reveal_card(game.player)
    end

    game.engine.prompt = {
      :prompt       => "Press enter to continue",
      :autocomplete => lambda {|input| nil },
      :accept       => lambda {|input|
        game.engine.prompt = nil

        treasure[].each do |t|
          game.move_card(t, player[:revealed], player[:hand])
          revealed.delete_at(revealed.index(t))
        end

        revealed.each do |c|
          game.move_card(c, player[:revealed], player[:discard])
        end
      }
    }
  }
}
