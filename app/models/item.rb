class Item < ApplicationRecord
    validates :tweet_id, {presence: true, uniqueness: true}

    #正規表現を定数に入れる
    DATE_FORMAT = /(\d{1}|\d{2})\/(\d{2}|\d{1})/
end


#(0?[1-9]|1[0-2])[\/](0?[1-9]|[12][0-9]|3[01])