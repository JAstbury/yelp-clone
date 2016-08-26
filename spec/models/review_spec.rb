require 'rails_helper'
require 'spec_helper'

describe Review, type: :model do
  it 'is invalid if the rating is more than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end

  it 'is invalid if the user has already reviewed the restaurant' do
    User.create(email: 'test@email.com', password: '123456')
    Restaurant.create(name: "Moe's Tavern", user_id: User.first.id)
    Review.create(user_id: User.first.id, restaurant_id: Restaurant.first.id, rating: 5)
    review = Review.create(user_id: User.first.id, restaurant_id: Restaurant.first.id, rating: 5)
    expect(review).to have(1).error
  end

end
