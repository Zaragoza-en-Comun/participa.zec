require 'httparty'

class ZaragoZenComun
  include HTTParty
  API_KEY = ''
  

  def self.base_path
    "https://intranet.zaragozaencomun.com/services/api/rest/json/?api_key=#{API_KEY}"
  end

  def self.account_info(username)
    method = 'account.info'
    url = "#{ base_path }&method=#{method}&username=#{username}"
    
    res = HTTParty.post(url)
    if res['status'] == 0
      res["result"] if res["result"]["validated"]
    end
  end
  
  def self.account_infobymail(email)
    method = 'account.infobymail'
    url = "#{ base_path }&method=#{method}&email=#{email}"
    res = HTTParty.post(url)
    if res['status'] == 0
      res["result"]
    else
      res
    end
    
  end
  
  #  account.create
  #by	username
  #	  email
  #	  name
  #	  password
  #	Returns JSON
  #		status: 0 = ok / -1 error
  #		result: guid
  def self.account_create(username, email, name, password)
    method = 'account.create'
    url = "#{ base_path }&method=#{method}&username=#{username}&email=#{email}&name=#{name}&password=#{password}&validate=true"
    res = HTTParty.post(url)
    
    if res['status'] == 0
      res["result"]
    else
      res
    end
  end
  
  
#  account.update
#  by	username
#    email
#    name
#    password (can be null)
#    Returns JSON
#      status: 0 = ok / -1 error
#      result: boolean (true)
  def self.account_update(username, email, name, password=nil)
    method = 'account.update'
    url = "#{ base_path }&method=#{method}&username=#{username}&email=#{email}&name=#{name}"
    url += "&password=#{password}" unless password.nil?
    res = HTTParty.post(url)

  end
  
  
  #  account.validate
  #  by	username
  #    Returns JSON
  #      status: 0 = ok / -1 is already validated
  #      result: boolean (true)

  #currently giving following error
  # {"status":-1,"message":"account_validate('diego') tiene un error de an\u00e1lisis"}

  def self.account_validate(username)
    method = 'account.validate'
    url = "#{ base_path }&method=#{method}&username=#{username}"
    
    res = HTTParty.post(url)
    
  end
  
  def self.account_delete(username)
    method = 'account.delete'
    url = "#{ base_path }&method=#{method}&username=#{username}"
    
    res = HTTParty.post(url)
  end
  
  def self.find_and_create_account(first_name, last_name, email, password)  
    user = account_infobymail(email)
    if ['status'] == 0
      username = user["result"]["username"]
    else
      username = generate_unique_username
      name = "#{first_name} #{last_name}"
      account_create(username, email, name, password)
    end    
    return username
  end
  
  def self.generate_unique_username
    username = ('a'..'z').to_a.shuffle[0,11].join
    return username
  end
end
