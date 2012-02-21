class ContactsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => [:create]

  respond_to :html

  def providers
     respond_with({ 'providers' => Oauth::Contacts::SUPPORTED_PROVIDERS })
   end

   #
   # GET Make request to provider for user authorization
   #
   def provider
     api = Oauth::Contacts.get_provider(params[:provider])

     respond_with do |format|
       format.html { redirect_to api.authorize_url }
     end
   end

   #
   # POST Call back from provider for get authorization of api access
   #
   def authorize
     api = Oauth::Contacts.get_provider(params[:provider])
     session[:code] = params[:code]

     respond_with do |format|
       format.html { redirect_to contacts_path(:provider => params[:provider]) }
     end
   end

   #
   # GET getting contacts from authorized provider
   #
   def contacts
     api = Oauth::Contacts.get_provider(params[:provider])
     api.code = session.delete(:code)

     @contacts = api.contacts
     respond_with(@contacts)
   end
end
