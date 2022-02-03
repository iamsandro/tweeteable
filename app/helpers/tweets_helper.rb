module TweetsHelper
  TIME_PATTERN = {
    " hours" => "h",
    " minutes" => "m",
    " days" => "d",
    " hour" => "h",
    " minute" => "m",
    " day" => "d",
    "about" => ""
  }.freeze

  def time_ago_converter(words)
    TIME_PATTERN.each_pair do |k, v|
      words.gsub!(k, v)
    end
    words
  end
end
