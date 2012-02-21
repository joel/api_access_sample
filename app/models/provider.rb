class Provider < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  belongs_to :user

  def oauth_contacts
    Oauth::Contacts.get_provider(self.name)
  end
  memoize :oauth_contacts

end
