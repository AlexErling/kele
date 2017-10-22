require 'httparty'
require 'json'
require './lib/roadmap.rb'
 
 class Kele
   include HTTParty
   include Roadmap
   
   # base_uri = 'https://www.bloc.io/api/v1'
 
   def initialize(email, password)
     response = self.class.post(api_url("sessions"), body: {"email": email, "password": password})
     raise "Invalid email or password" if response.code == 404
     @auth_token = response["auth_token"]
   end
   
  def get_me
    response = self.class.get(api_url('users/me'), headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end
  
  def get_mentor_availability(mentor_id)
    response = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end
  
  def get_messages(page_num=nil)
    if page_num == nil
      response = self.class.get(api_url("message_threads"), headers: { "authorization" => @auth_token })
    else
      response = self.class.get(api_url("message_threads?page=#{page_num}"), headers: { "authorization" => @auth_token })
    end
    @messages = JSON.parse(response.body)
  end
  
  def create_message(user_id, recipient_id, subject, message)
    response = self.class.post(api_url("messages"),
      body: {
        "user_id": user_id,
        "recipient_id": recipient_id,
        "subject": subject,
        "stripped_text": message
        },
        headers: {"authorization" => @auth_token})
    puts "The message has been sent!" if response.success?
  end
  
  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
    response = self.class.post(api_url("checkpoint_submissions"),
      body: {
        "assignment_branch": assignment_branch,
        "assignment_commit_link": assignment_commit_link,
        "checkpoint_id": checkpoint_id,
        "comment": comment,
        "enrollment_id": enrollment_id
        },
      headers: {"authorization" => @auth_token})
    puts "The submission was sent!" if response.success?
  end  
  
  
   private
 
   def api_url(endpoint)
     "https://www.bloc.io/api/v1/#{endpoint}"
   end
 
 
 end