#1.get the player's name
#2.deal card to player and dealer and count the total 
#3.deal one more card to player if player choose to hit
#4.deal cards to dealer if player decide to stay until total is larger than player


#calculate total value of cards
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

#check if player win or not
def check_player_win_or_busted(card, amount)
  if amount == 21
    puts "Congratulations, you hit blackjack! You win!!!"
    true
  elsif amount > 21
    puts "Sorry, it looks like you busted!"
    true
  end
end

#check if dealer win or not
def check_dealer_win_or_busted(card, amount)
  if amount == 21
    puts "Dealer hit blackjack! Dealer win..."
    true
  elsif amount > 21
    puts "Dealer busted...You win!!!"
    true
  end
end

#display all of cards and determin who win the game
def show_all_cards(dealer_card, d_amount, player_card, p_amount)
  puts "Dealer's cards:"
  dealer_card.each do |arr|
    puts "=> #{arr}"
  end
  
  puts "\nYour cards:"
  player_card.each do |arr|
    puts "=> #{arr}"
  end
  
  puts "\nSorry, dealer wins..." if d_amount > p_amount
  puts "\nCongratulations, You win!!!" if d_amount < p_amount
  puts "\nTie game!!!" if d_amount == p_amount
end

#dealer deal the card to himself when player stay
def dealer_dealing(deck, dealer_card, dealer_amount, player_card, player_amount)
  if dealer_amount >= 17
    show_all_cards(dealer_card, dealer_amount, player_card, player_amount)
    true
  else
    begin 
      dealer_card << deck.pop
      dealer_amount = calculate_total(dealer_card)
      puts "Dealing new card for dealer: #{dealer_card.last}"
      puts "Dealer total is now: #{dealer_amount}"
      
      #check if dealer hit blackjack or bust
      if check_dealer_win_or_busted(dealer_card, dealer_amount)
        break
      #dealer didn't won but total value over 17
      elsif dealer_amount >= 17
        show_all_cards(dealer_card, dealer_amount, player_card, player_amount)
        break
      end
    end while dealer_amount < 17
    true
  end
end

#constant array of suits and value 
SUITS = ['S', 'H', 'D', 'C']
VALUE = ['Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']

puts "What is your name?"
name = gets.chomp

begin
  deck = SUITS.product(VALUE)
  deck.shuffle!

  dealer = []
  player = []
  
  #get first two card for both of player
  2.times do 
    dealer << deck.pop
    player << deck.pop
  end

  now_dealer_total = calculate_total(dealer)
  now_player_total = calculate_total(player)
  puts "Dealer has: #{dealer[0]} and #{dealer[1]}, for a total of #{now_dealer_total}"
  puts "#{name} has: #{player[0]} and #{player[1]}, for a total of #{now_player_total}" 
  
    loop do
      #break if player hit or bust
      break if check_player_win_or_busted(player, now_player_total)
      
      puts "\n1) hit 2) stay"
      decision = gets.chomp.to_i
    
      if decision == 1
        player << deck.pop
        now_player_total = calculate_total(player)
        puts "Dealing card to player: #{player.last}"
        puts "#{name} total is now: #{now_player_total}"
      elsif decision == 2
        puts "You choose to stay!"
        break if dealer_dealing(deck, dealer, now_dealer_total, player, now_player_total)
      end
    end

  puts "\nPlay again? (Y/N)"
  yes_or_no = gets.chomp.downcase
end while yes_or_no == 'y'