require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
	def setup
		@admin_session = { :user_id => users(:admin).id }
	end
	
  test "should get index" do
    get :index, nil, @admin_session
    assert_response :success
    assert_not_nil assigns(:categories)
  end
   
  test "should get new" do
    get :new, nil, @admin_session
    assert_response :success
  end
 
  test "should create category" do
    assert_difference('Category.count') do
      post :create, {:category => { :name => 'foo category' }}, @admin_session
    end
  
    assert_redirected_to admin_categories_path
  end
  
  test "should get edit" do
    get :edit, {:id => categories(:musics).id}, @admin_session
    assert_response :success
  end
  
  test "should update category" do
    put :update, {:id => categories(:musics).id, :category => { :name => 'foo category' }}, @admin_session
    assert_redirected_to edit_admin_category_path(assigns(:category))
  end
  
  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, {:id => categories(:musics).id}, @admin_session
    end
  
    assert_redirected_to admin_categories_path
  end
 end
