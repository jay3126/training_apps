class UsersController < ApplicationController
  require 'rest_client'
  require 'httparty'
  USERNAME = "admin" # needed to access the APi
  PASSWORD = "admin" # needed to access the APi
  API_BASE_URL = "http://localhost:3030" # base url of the API
  def index
    uri = "#{API_BASE_URL}/users.json" # specifying json format in the URl
    rest_resource = RestClient::Resource.new(uri, USERNAME, PASSWORD)
    users = rest_resource.get
    @users = JSON.parse(users, :symbolize_names => true)
  end

  def new

  end

  def create
    uri = "#{API_BASE_URL}/users"
    payload = params.to_json
    rest_resource = RestClient::Resource.new(uri, USERNAME, PASSWORD)
    begin
      rest_resource.post payload , :content_type => "application/json"
      flash[:notice] = "User Saved successfully"
      redirect_to users_path
    rescue Exception => e
     flash[:error] = "User Failed to save"
     render :new
    end
  end

  def edit
    uri = "#{API_BASE_URL}/users/#{params[:id]}.json"
    rest_resource = RestClient::Resource.new(uri, USERNAME, PASSWORD)
    users = rest_resource.get
    @user = JSON.parse(users, :symbolize_names => true)
  end
  def update
    uri = "#{API_BASE_URL}/users/#{params[:id]}"
    payload = params.to_json
    rest_resource = RestClient::Resource.new(uri, USERNAME, PASSWORD)
    debugger
    # auth = {:username => "admin", :password => "admin"}
    # options = {body: {first_name: params[:first_name],last_name: params[:last_name],email: params[:email],id: params[:id]}.to_json,basic_auth: auth}
    # @result = HTTParty.put("http://localhost:3030",options)
    begin
      rest_resource.put payload , :content_type => "application/json"
      flash[:notice] = "User Updated successfully"
    rescue Exception => e
      flash[:error] = "User Failed to Update"
    end
    redirect_to users_path
  end

  def destroy
    uri = "#{API_BASE_URL}/users/#{params[:id]}"
    rest_resource = RestClient::Resource.new(uri, USERNAME, PASSWORD)
    begin
     rest_resource.delete
     flash[:notice] = "User Deleted successfully"
    rescue Exception => e
     flash[:error] = "User Failed to Delete"
    end
    redirect_to users_path
   end










end
