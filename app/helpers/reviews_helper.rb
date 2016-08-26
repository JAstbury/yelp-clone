module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    rating = rating.round
    remainder = (5 - rating.round)
    "★" * rating.round + "☆" * remainder.ceil
  end
end
