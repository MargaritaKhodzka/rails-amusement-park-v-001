class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    enough_tickets, tall_enough = attraction_requirements
    
    if enough_tickets && tall_enough
      start_ride
    elsif !enough_tickets && tall_enough
      'Sorry. You do not have enough tickets to ride the Roller Coaster.'
    elsif enough_tickets && !tall_enough
      'Sorry. You are not tall enough to ride the Roller Coaster.'
    else
      'Sorry. You do not have enough tickets to ride the Roller Coaster. You are not tall enough to ride the Roller Coaster.'
    end
  end

  def attraction_requirements
    enough_tickets, tall_enough = false

    if self.user.tickets >= self.attraction.tickets
      enough_tickets = true
    end

    if self.user.height >= self.attraction.min_height
      tall_enough = true
    end

    return [enough_tickets, tall_enough]
  end

  def start_ride
    happiness_level = self.user.happiness + self.attraction.happiness_rating
    nausea_level = self.user.nausea + self.attraction.nausea_rating
    tickets_left = self.user.tickets - self.attraction.tickets
    self.user.update(:happiness => happiness_level, :nausea => nausea_level, :tickets => tickets_left)
    "Thanks for riding the #{self.attraction.name}!"
  end
end
