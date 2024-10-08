class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]
  
    # GET /users
    # GET /users.json
    def index
      @users = User.all
    end

    #GET ALL USERS
    def get_all_users
      @users = User.all
    end
  
    # GET /users/1
    # GET /users/1.json
    def show
    end
  
    # GET /users/new
    def new
      @user = User.new
    end
  
    # GET /users/1/edit
    def edit
    end
  
    def login
    end

    def home
    end

    # POST /users
    # POST /users.json
    def create
      @user = User.new(user_params)

      if @user.save
        flash[:sucess] = "Usuário cadastrado com sucesso."
        redirect_to home_path  
      else
        flash[:error] = @user.errors.full_messages.to_sentence
        render :new
      end
    end
  
    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def create_session
      # Aqui você pode lidar com a autenticação do usuário
      user = User.find_by(email: params[:email])
  
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = "Login bem-sucedido!"
        redirect_to home_path  
      else
        flash[:error] = "Email ou senha inválidos."
        render :login
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:nome, :email, :raw_password, :raw_password_confirmation)
      end

  end
  