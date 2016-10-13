require "rails_helper"

RSpec.describe TasksController, :type => :controller do
  let!(:task) { FactoryGirl.create :task, :with_tags }
  let!(:task1) { FactoryGirl.create :task, :with_tags }

  describe "GET #index" do

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template 'index'
    end

    it "loads all of the tasks into @tasks" do
      get :index
      expect(assigns(:tasks)).to match_array([task, task1])
    end

    it "loads all of the tasks filter by tag into @tasks" do
      get :index, { tags: 'Tag'}
      expect(assigns(:tasks)).to match_array([])
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, { id: task.id }
      expect(response).to render_template 'show'
    end

    it "loads one task into @task" do
      get :show, { id: task.id }
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "GET #new" do
    it 'renders the new template' do
      get :new
      expect(response).to render_template 'new'
    end

    it "assigns a new task as @task" do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "GET #edit" do
    it 'renders the edit template' do
      get :edit, { id: task.to_param }
      expect(response).to render_template 'edit'
    end

    it "assigns the requested task as @task" do
      get :edit, { id: task.to_param }
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, { task: FactoryGirl.attributes_for(:task) }
        }.to change(Task, :count).by(1)
      end

      it "assigns a newly created task as @task" do
        post :create, { task: FactoryGirl.attributes_for(:task) }
        expect(assigns(:task)).to be_a(Task)
        expect(assigns(:task)).to be_persisted
      end

      it "redirects to the created task" do
        post :create, { task: FactoryGirl.attributes_for(:task) }
        expect(response).to redirect_to(Task)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved task as @task" do
       post :create, { task: FactoryGirl.attributes_for(:task, title: nil) }
        expect(assigns(:task)).to be_a_new(Task)
      end

      it "re-renders the 'new' template" do
        post :create, { task: FactoryGirl.attributes_for(:task, title: nil) }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do

      it "updates the requested task" do
        put :update, { id: task.to_param, task: { title: 'New title' } }
        task.reload
      end

      it "assigns the requested task as @task" do
        put :update, { id: task.to_param, task: { title: 'New title' } }
        expect(assigns(:task)).to eq(task)
      end

      it "redirects to the task" do
        put :update, { id: task.to_param, task: { title: 'New title' } }
        expect(response).to redirect_to(Task)
      end
    end

    context "with invalid params" do
      it "assigns the task as @task" do
        put :update, { id: task.to_param, task: { title: nil } }
        expect(assigns(:task)).to eq(task)
      end

      it "re-renders the 'edit' template" do
        put :update, { id: task.to_param, task: { title: nil } }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      expect {
        xhr :delete, :destroy, { id: task.to_param }
      }.to change(Task, :count).by(-1)
    end
  end

  describe "POST #postpone" do
    it "assigns the requested task as @task" do
      xhr :post, :postpone, { id: task.to_param, task: { postpone_date: DateTime.tomorrow } }
      expect(assigns(:task)).to eq(task)
    end
  end
end

