class NotesController < ApplicationController

	def create
		puts "POST ID PARAMS: " + params[:note][:post_id]
		post_id = params[:note][:post_id]
		note_text = params[:note][:text]
		puts "POST ID : " + post_id

		note = Note.new(:post_id => post_id, :text => note_text)
		puts "NOTE POST ID: " + note.post_id.to_s
		if params[:date]
			@date = Date.parse(params[:date])
		else
			@date = Date.today
			params[:date] = @date
		end

		if not note.save
			redirect_to controller: 'posts', action: 'index', date: @date
		end


		@post = Post.find_by(post_id)
		puts "POST ID TO SAVE NOTE TO: " + post_id.to_s
		redirect_to controller: 'posts', action: 'edit', date: @date
	end

	def destroy
	end

end
