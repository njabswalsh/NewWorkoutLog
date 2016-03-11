class NotesController < ApplicationController

	def create
		note_text = params[:note][:text]
		post_id = params[:note][:post_id]
		return_to = params[:note][:return_to]
		if not note_text == ""
			visibility_list = params[:note][:visibility]
			visibility_list.delete("0")
			if visibility_list
				visibility_string = visibility_list.join(',')
			else
				visibility_string = ""
			end

			note = Note.new(:post_id => post_id, :text => note_text, :visibility => visibility_string)

			if not note.save
				redirect_to controller: 'posts', action: 'index'
			end
		end
		if not params[:button_action] == "add_note"
			redirect_to params[:button_action]
		else
			@post = Post.find(post_id)
			if not return_to == ""
				redirect_to controller: 'posts', action: 'edit', :date => @post.date.to_s, :return_to => return_to
			else
				redirect_to controller: 'posts', action: 'edit', :date => @post.date.to_s
			end
		end
	end

	def update
		post_id = params[:note][:post_id]
		note_text = params[:note][:text]
		return_to = params[:note][:return_to]
		visibility_list = params[:note][:visibility]
		visibility_list.delete("0")
		if visibility_list
			visibility_string = visibility_list.join(',')
		else
			visibility_string = ""
		end

		note = Note.find(params[:note_id])
		note.text = note_text
		note.visibility = visibility_string
		if not note.save
			redirect_to controller: 'posts', action: 'index'
		end

		if not params[:button_action] == "add_note"
			redirect_to params[:button_action]
		else
			@post = Post.find(post_id)
			if not return_to == ""
				redirect_to controller: 'posts', action: 'edit', :date => @post.date.to_s, :return_to => return_to
			else
				redirect_to controller: 'posts', action: 'edit', :date => @post.date.to_s
			end
		end
	end

	def destroy
		@note = Note.find_by(id: params[:id])
		date = params[:date]
		return_to = params[:return_to]
		@note.destroy
		if not return_to == ""
			redirect_to controller: 'posts', action: 'edit', :date => date.to_s, :return_to => return_to
		else
			redirect_to controller: 'posts', action: 'edit', :date => date.to_s
		end
	end

end
