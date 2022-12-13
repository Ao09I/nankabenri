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
      "expansions" => "attachments.media_keys",
      "tweet.fields" => "attachments,created_at,entities,id,lang",
      "media.fields" => "url,media_key"
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
    new_product_response = parsed_response["data"].map.with_index do |tweet|
      {
        id: tweet["id"],
        text: tweet["text"],
        image_url: 
        #メディアのキーが存在するならば
        if keys = parsed_response["data"][0]["attachments"]["media_keys"].present?
          #キーを頼りにmediaのurlを探しに行く
          #if tweet["entities"]["urls"][0]["images"].present?
            #tweet["entities"]["urls"][0]["images"].map { |image| image["url"]}
          #else　[]　end
          parsed_response["includes"]["media"].select
          { |media| keys.include?(media["media_key"]) }.map 
          { |media| media["url"] }
        else
          []
        end
      }
      #select
    end.select do |tweet|
      tweet[:text].include?("🌱新商品🌱") #&& 
    end


    #取得したツイートにそれぞれ行う処理
    new_product_response.each do |tweet|
      #itemにtweed_idを頼りに取得したツイートを持ってくる
      item = Item.find_by(tweet_id: tweet[:id])
      #nextループ処理を抜けて次の処理へ
      next if item.present?
      new_product = tweet[:text].slice(/『.+?』/)
      #発売日に入れる方法
      new_item = Item.new(name: new_product , price: tweet[:text].slice(/\d?*円/), start_time: Time.zone.now, tweet_id: [:id])
      new_item.save
      end
    end
end


