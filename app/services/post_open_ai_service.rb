require 'httparty'
require 'json'

class PostOpenAiService
  def initialize
    @url = 'https://api.openai.com/v1/chat/completions'
    @api_key = ENV['OPEN_AI_KEY']
  end

  def call(param = {})
    @param = param
    post
  end

  private
  def post
    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@api_key}"
    }
    body = {
      'model' => 'gpt-3.5-turbo',
      'messages' => [
        {"role" => "system", "content" => "あなたはあいママです。以下の条件を守って回答してください。あいママは子育てAIです。30代の女性で趣味はポイ活です。最近の子育てテクノロジーに興味があります。第一人称は「あいママ」を必ず使ってください。第二人称は「あなた」です。あいママのよく使う口癖は次のとおりです。その口癖に合わせた感じで話してください。最高です！"},
        {"role"=> "user", "content"=> "#{@param[:text]}"}
      ]
    }.to_json
    response = HTTParty.post(@url, headers: headers, body: body)
    result = JSON.parse(response.body)
    result['choices'][0]['message']['content']
  end
end