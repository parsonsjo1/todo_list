require 'spec_helper'

describe "Editing todo items" do
	let!(:todo_list) {TodoList.create(title:"Grocery List", description: "Groceries")}
	let!(:todo_item) {todo_list.todo_items.create(content: "Milk")}

	def visit_todo_list(list)
		visit "/todo_lists"
		within "#todo_list_#{list.id}" do
			click_link "List Items"
		end
	end

	it "is successful with valid content" do
		 visit_todo_list(todo_list)
		 
		 within("#todo_items_#{todo_item.id}") do
			click_link "Edit"	 	
		 end

		 fill_in "Content", with: "Lots of Milk"
		 click_button "Save"
		 expect(page).to have_content("Saved todo list item")

		 todo_item.reload
		 expect(todo_item.title).to eq("Lots of Milk")
	end
end