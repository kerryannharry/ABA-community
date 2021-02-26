class GroupsController < ApplicationController
    get '/groups/:id' do
        redirect_if_not_logged_in
        @group = Group.find_by(id: params[:id])
        if current_user.groups.include?(@group)
            erb:"groups/page"
        else
            redirect "users/#{current_user.id}"
        end
    end
end