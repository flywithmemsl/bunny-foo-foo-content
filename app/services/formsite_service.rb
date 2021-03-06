require 'rest-client'
class FormsiteService
  def initialize
  end

  def is_useragent_valid(useragent)
    !unavailable_useragents.include? useragent
  end

  def is_impressionwise_test_success(user)
    response = RestClient.get("http://post.impressionwise.com/verifyme.aspx", {
      params: {
        "code": '837001',
        "pwd": '1ScRee',
        "email": user[:email],
        "fname": user[:first_name],
        "lname": user[:last_name]
      }
    })
    result = JSON.parse(response)["result"]
    result == "CERTIFIED" || result == "DISCRETIONARY"
  end

  private

  def unavailable_useragents
    return [
      'Googlebot',
      'MSNBot',
      'Baiduspider',
      'Bing',
      'Inktomi Slurp',
      'Yahoo',
      'Ask Jeeves',
      'FastCrawler',
      'InfoSeek Robot 1.0',
      'Lycos',
      'YandexBot',
      'MediaPartners Google',
      'Crazy Webcrawler',
      'AdsBot Google',
      'Feedfetcher Google',
      'Curious George',
      'Alexa Crawler',
      'Majestic-12',
      'Uptimebot',
      'Dataprovider.com',
      'Baiduspider',
      'bot',
      'slurp',
      'crawler',
      'spider',
      'curl',
      'facebook',
      'fetch',
      'Unknown',
      'unknown',
      'ips-agent',
      'PhantomJS',
      'phantomjs',
      'Python',
      'python',
      'php',
      'perl',
      'SafeDNSBot',
      'safednsbot',
      'BB10',
      'synapse',
      'Synapse',
      'libcurl',
      'zgrab',
      'Magic Browser',
      'magic browser',
      'SemrushBot',
      'semrushBot',
      'GrapeshotCrawler',
      'grapeshot',
      'Pinterestbot',
      'pinterestbot',
      'Java',
      'java',
      'masscan',
      'MegaIndex',
      'megaindex',
      'CFNetwork',
      'CFNetwork',
      'CRAZYWEBCRAWLER ',
      'CRAZYWEBCRAWLER ',
      'Cliqzbot',
      'zoominfobot',
      'zoominfobot',
      'DomainSONOCrawler'
    ]
  end
end
