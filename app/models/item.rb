class Item < ApplicationRecord
    validates :tweet_id, {presence: true, uniqueness: true}

    #正規表現を定数に入れる
    DATE_FORMAT = /(\d{1}|\d{2})\/(\d{2}|\d{1})/
    ITEM_NAME = /^[\u{10000}-\u{10FFFF}]新商品[\u{10000}-\u{10FFFF}]$/
end


#(0?[1-9]|1[0-2])[\/](0?[1-9]|[12][0-9]|3[01])