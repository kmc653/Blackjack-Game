#1.get the player's name
#2.deal card to player and dealer and count the total 
#3.deal one more card to player if player choose to hit
#4.deal cards to dealer if player decide to stay until total is larger than player


def calculate_total(card)
  amount = 0
  card.each do |arr|
    if arr[1] == 'Ace' && amount < 11
      amount += 11
    elsif arr[1] == 'Ace' && amount >= 11
      amount += 1
    elsif arr[1] == '10' || arr[1] == 'J' || arr[1] == 'Q' || arr[1] == 'K'
      amount += 10
    else
      amount += arr[1].to_i
    end
  end
  amount
end

def deal(card)
  card.unshift([FACE.sample, NUMBER.sample])
end

def check_win_busted(card)
  status = false
  total = calculate_total(card)
  if total == 21
    puts "Congratulations, you hit blackjack! You win!"
  elsif total > 21
    puts "#{name} busted!"
  end 
end

FACE = ['S', 'H', 'D', 'C']
NUMBER = ['Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
VALUE = {}

loop do 
  dealer = []
  player = []
  puts "What is your name?"
  name = gets.chomp

  2.times do 
    deal(dealer)
    deal(player)
  end
  now_dealer_total = calculate_total(dealer)
  now_player_total = calculate_total(player)
  puts "Dealer has: #{dealer[0]} and #{dealer[1]}, for a total of #{now_dealer_total}"
  puts "#{name} has: #{player[0]} and #{player[1]}, for a total of #{now_player_total}" 
  
  loop do 
    puts "\nWhat would you like to do? 1) hit 2) stay"
    hit_or_stay = gets.chomp.to_i

    if hit_or_stay == 1
      deal(player)
      now_player_total = calculate_total(player)
      puts "Dealing card to player: #{player[0]}"
      puts "{name} total is now: #{now_player_total}"
      check_win_busted(player)
    end
  end
end









