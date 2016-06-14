require 'spec_helper'

describe "Creating todo items" do
	let!(:todo_list) {TodoList.create(title:"Grocery List", description: "Groceries")}

	it "is successful with valid content" do
		 visit_todo_list(todo_list)
		 click_link "New Todo Item"
		 fill_in "Content", with: "Milk"
		 click_button "Save"
		 expect(page).to have_content("Added todo list item.")

		 within "ul.todo_items li" do
		 	expect(page).to have_content("Milk")
		 end
	end
end