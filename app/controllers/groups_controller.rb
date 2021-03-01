class GroupsController < ApplicationController
    get '/groups'do
        @groups = Group.all 
        erb:"groups/index"
    end

    get '/groups/:id/join' do
        redirect_if_not_logged_in
        group = Group.find_by(id: params[:id])
        if current_user.groups.include?(group)
            GroupUser.find_by(user: current_user, group: group).destory
        else
            GroupUser.create(user: current_user, group: group)
        end
            redirect "/groups/#{group.id}"
    end

    post '/groups/:id/posts' do
        redirect_if_not_logged_in
        group = Group.find_by(id: params[:id])
        post = Post.create(user: current_user, group: group, title: params[:title], body: params[:body])
        if post.valid?
            flash[:success]= "Post successfully created!"
        else 
            flash[:error]= post.errors.full_messages.to_sentence
        end
        redirect "/groups/#{group.id}"
    end
    get '/groups/:id' do
        redirect_if_not_logged_in
        @group = Group.find_by(id: params[:id])
        if current_user.groups.include?(@group)
            erb:"groups/show"
        else
            redirect "/users/#{current_user.id}"
        end
    end

    get '/groups/:id/edit'do
    redirect_if_not_logged_in
    @group = Group.find_by(id: params[:id])
    if current_user.groups.include?(@group)
        erb:"groups/edit"
    else
        redirect "/users/#{current_user.id}"
    end

    patch '/groups/:id' do 
    redirect_if_not_logged_in
    group = Group.find_by(id: params[:id])
    post = Post.update(user: current_user, group: group, title: params[:title], body: params[:body])
    end 

    delete '/groups/:id' do
        redirect_if_not_logged_in
      session.clear
      redirect "/groups/#{group.id}"
      end
end 
end