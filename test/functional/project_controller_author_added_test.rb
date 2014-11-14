require File.dirname(__FILE__) + '/../test_helper'

class ProjectControllerAuthorAddedTest < ActionController::TestCase
  fixtures :projects, :users
  tests ProjectsController

  def setup
    @author = User.first

    @request.session[:user_id] = @author.id
    User.stubs(:current).returns(@author)
    User.any_instance.stubs(:allowed_to?).returns(true)
  end

  test 'should be able to set project author' do

    post :create, project: {
      name: 'Test project',
      identifier: 'test-project',
      author_id: @author.id
    }

    project = Project.find_by_name('Test project')

    assert_redirected_to '/projects/test-project/settings'
    assert_equal @author.id, project.author_id
  end

  test 'should not be able to set non-existing project author' do

    assert_no_difference 'Project.count' do
      post :create, project: {
          name: 'Test project',
          identifier: 'test-project',
          author_id: 1000 #does not exist in the system
      }

      assert_response :success
    end

  end

end