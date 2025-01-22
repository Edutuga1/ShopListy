class ListMailer < ApplicationMailer
  def share_list(friend, list)
    @friend = friend
    @list = list
    @user = list.user

    # Send the email to the friend with the list's details
    mail(to: @friend.email, subject: "#{@user.name} shared a list with you!") do |format|
      format.text { render plain: "Hello, #{@friend.name}! #{@user.name} has shared a list with you: #{@list.name}. View the list: #{list_url(@list)}" }
      format.html { render 'share_list_email' } # Use HTML format if you prefer to send a styled email
    end
  end
end
