require "rails_helper"

describe "tweets", type: :request do
  it "index path respond with http success status code" do
    get "/api/tweets"
    expect(response).to have_http_status(:ok)
  end

  it "index path returns a json with all tweets" do
    user = User.create(name: "Test1", username: "Testino", email: "test@mail.com", password: "123456")
    Tweet.create(body: "This is a test to first tweet", user: user)
    get "/api/tweets"
    tweets = JSON.parse(response.body)
    expect(tweets.size).to eq 1
  end
end

# **********************SHOW**********************

describe "show path", type: :request do
  it "respond with http success status code" do
    user = User.create(name: "Test1", username: "Testino", email: "test@mail.com", password: "123456")
    tweet = Tweet.create(body: "This is a test to first tweet", user: user)
    get api_tweet_path(tweet)
    expect(response).to have_http_status(:ok)
  end

  it "respond with the correct genre", type: :request do
    user = User.create(name: "Test1", username: "Testino", email: "test@mail.com", password: "123456")
    tweet = Tweet.create(body: "This is a test to first tweet", user: user)
    get api_tweet_path(tweet)
    actual_tweet = JSON.parse(response.body)
    expect(actual_tweet["id"]).to eql(tweet.id)
  end

  it "returns http status not found", type: :request do
    get api_tweet_path("xxx"), params: { id: "xxx" }
    expect(response).to have_http_status(:not_found)
  end
end
