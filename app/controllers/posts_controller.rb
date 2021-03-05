class PostsController < ApplicationController
    get '/posts/:id/edit' do
        redirect_if_not_logged_in
        @post = Post.find_by(id: params[:id])
        if @post.user == current_user
            erb :'posts/edit'
        else 
            redirect back
        end
    end
    patch '/posts/:id' do
        redirect_if_not_logged_in
        post = Post.find_by(id: params[:id])
        if post.user == current_user
            post.update(title: params[:title], body: params[:body])
            if post.valid?
                flash[:success] = "post successfully updated!"
                redirect "/groups/#{post.group_id}"
            else
                flash[:error] = post.errors.full_messages.to_sentence
                redirect "/groups/#{post.id}/edit"
            end
        else 
            flash[:error] = "Unauthorized"
            redirect "/groups/#{post.group_id}"
        end
    end
    delete '/posts/:id' do
        redirect_if_not_logged_in
        post = Post.find_by(id: params[:id])
        if post.user == current_user
            if post.destroy
                flash[:success] = "post successfully deleted!"
                redirect "/groups/#{post.group_id}"
            else 
                flash[:error] = post.errors.full_messages.to_sentence
            end
        else 
            redirect back
        end
    end
end 