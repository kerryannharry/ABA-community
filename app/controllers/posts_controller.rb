class PostsController < ApplicationController
    get '/posts/:id/edit' do
        redirect_if_not_logged_in
        @post = Post.find_by(params[:id])
        if @post.user == current_user
            erb :'posts/edit'
        else 
            redirect back
        end
    end

    patch '/posts/:id' do
        redirect_if_not_logged_in
        post = Post.find_by(params[:id])
        if post.user == current_user
            post.update(title: params[:title], body: params[:body])
            flash[:success] = "post successfully updated!"
            redirect "/groups/#{post.group_id}"
        else 
            flash[:error] = post.errors.full_messages.to_sentence
            redirect "/posts/#{post.id}/edit"
        end
    end

    delete '/posts/:id' do
        redirect_if_not_logged_in
        post = Post.find_by(params[:id])
        if post.user == current_user
            post.destroy
            flash[:success] = "post successfully deleted!"
        else 
            flash[:error] = post.errors.full_messages.to_sentence
        end

        redirect back
    end

end 