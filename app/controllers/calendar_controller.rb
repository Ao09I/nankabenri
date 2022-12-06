class CalendarController < ApplicationController
  #topアクションの時にfetch_tweets実行する
  before_action :fetch_tweets, only: [:top]

  def top
   @items = Item.all 
  end

  def fetch_tweets

    #.envから変数を読み込む
    bearer_token = ENV.fetch('TWITTER_API_TOKEN')
    username = 'chiikawa_market'

    query_params = {
      "max_results" => 10,
      "expansions" => "author_id",
      "tweet.fields" => "attachments,author_id,conversation_id,created_at,entities,id,lang",
    }

    #ユーザー情報の取得
    endpoint_url_user_info = "https://api.twitter.com/2/users/by/username/:username".gsub(':username', username)
    response_user_info = get_user_info(endpoint_url_user_info, bearer_token)
    #puts 'ユーザー情報の取得結果'
    #puts response_user_info.code, JSON.pretty_generate(JSON.parse(response_user_info.body))

    # ユーザーのツイートの取得
    id = JSON.parse(response_user_info.body)['data']['id']
    endpoint_url_user_tweets = "https://api.twitter.com/2/users/:id/tweets".gsub(':id', id)
    response_user_tweets = get_user_tweets(endpoint_url_user_tweets, bearer_token, query_params)
    #puts 'ユーザーのツイートの取得結果'
    puts JSON.pretty_generate(response_user_tweets)

  end
 
  def get_user_info(url, bearer_token)
    options = {
    method: 'get',
    headers: {
      "User-Agent" => "v2RubyExampleCode",
      "Authorization" => "Bearer #{bearer_token}"
      },
    }
    request = Typhoeus::Request.new(url, options)
    response = request.run
    return response
  end

  def get_user_tweets(url, bearer_token, query_params)
    options = {
      method: 'get',
      headers: {
        "User-Agent" => "v2RubyExampleCode",
        "Authorization" => "Bearer #{bearer_token}"
      },
      params: query_params
    }
    request = Typhoeus::Request.new(url, options)
    response = request.run
    parsed_response = JSON.parse(response.body)

    #map
    new_product_response = parsed_response["data"].map do |tweet|
      {
        id: tweet["id"],
        text: tweet["text"],
        image_url: 
        if tweet["entities"]["urls"].present?
          if tweet["entities"]["urls"][0]["images"].present?
            tweet["entities"]["urls"][0]["images"].map { |image| image["url"]}
          else
            []
          end
        else
          []
        end
      }
      #select
    end.select do |tweet|
      tweet[:text].include?("新商品")
    end


    new_product_response.each do |tweet|
      item = Item.find_by(tweet_id: tweet['id'])
      #next present 存在してるか　ループを抜ける
      next if item.present?
      #値段、日付、画像
      new_item = Item.new(name: 'test', price: 1000, start_time: Time.zone.now, tweet_id: tweet['id'])
      new_item.save
    end
  end
end


