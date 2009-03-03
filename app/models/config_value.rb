class ConfigValue < ActiveRecord::Base
  def self.set_key(mykey, myvalue)
    cv = ConfigValue.find_by_key(mykey)
    cv.value = 0
    cv.save
  end
end
