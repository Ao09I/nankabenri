class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(name: params[:name], email: params[:email], password: params[:password])
        if @user.save
            #flashどこに出てくる？？
            flash[:notice] = "登録完了しました"
            redirect_to("/trade/index")
        else
            flash[:notice] = "登録失敗しました"
            render("users/new")
        end
    end

    def login
        @user = User.find_by(email: params[:email], password: params[:password], name: params[:name])
        if @user
            session[:user_id] = @user.id
            flash[:notice] = "ログインしました"
            #リダイレクト効かない問題
            redirect_to("/userpage")
        else
            flash[:notice] = "ログインできませんでした"
            render("users/login_form")
        end
    end

    def login_form
        
    end

    def logout
        session[:user_id] = nil
        flash[:notice] = "ログアウトしました"
        redirect_to("/login")
    end
end
