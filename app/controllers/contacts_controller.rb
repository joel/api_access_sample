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
     provider = current_user.providers.where(:name => params[:provider]).first
     api_access = provider.oauth_contacts

     puts "api_access => #{api_access}"

     respond_with do |format|
       format.html { redirect_to api_access.authorize_url }
     end
   end

   #
   # POST Call back from provider for get authorization of api access
   #
   def authorize
     provider = current_user.providers.where(:name => params[:provider]).first
     api_access = provider.oauth_contacts
     session[:code] = params[:code]

     puts "api_access => #{api_access}"

     respond_with do |format|
       format.html { redirect_to contacts_path(:provider => params[:provider]) }
     end
   end

   #
   # GET getting contacts from authorized provider
   #
   def contacts
     provider = current_user.providers.where(:name => params[:provider]).first
     api_access = provider.oauth_contacts
     api_access.code = session.delete(:code) # cleaning session

     puts "api_access => #{api_access}"

     @contacts = api_access.contacts
     respond_with(@contacts)
   end
end
