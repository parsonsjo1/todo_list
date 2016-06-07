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
		 
		 within("#todo_item_#{todo_item.id}") do
			click_link "Edit"	 	
		 end

		 fill_in "Content", with: "Lots of Milk"
		 click_button "Save"

		 expect(page).to have_content("Saved todo list item.")

		 todo_item.reload
		 expect(todo_item.content).to eq("Lots of Milk")
	end

	it "is unsuccessful with no content" do
		 visit_todo_list(todo_list)
		 
		 within("#todo_item_#{todo_item.id}") do
			click_link "Edit"	 	
		 end

		 fill_in "Content", with: ""
		 click_button "Save"

		 expect(page).to_not have_content("Saved todo list item")
		 expect(page).to have_content("Content can't be blank")

		 todo_item.reload
		 expect(todo_item.content).to eq("Milk")
	end

	it "displays an error when character length is less than 2" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: "H"
		click_button "Save"
		within("div.flash") do
			expect(page).to have_content("There was a problem adding that todo list item.")
		end
		expect(page).to have_content("Content is too short")
	end
end