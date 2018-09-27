class Admin::DepartmentUsersController < Admin::BaseController

  before_action :load_department, only: [:index, :add_member, :destroy]
  before_action :load_user, only: [ :destroy]

  def index
    @members = @department.users
    @user_role = DepartmentUser.new
  end

  def add_member
    department_user = DepartmentUser.new(department_roles_params)
    department_user.department_id = @department.id
    if department_user.save
      flash[:success] = 'Chefe adicionado com sucesso.'
      redirect_to admin_department_members_path
    else
      flash[:error] = 'Erro ao adicionar Chefe.'
      render :index
    end
  end

  def destroy
    @department.users.destroy(@user)
    flash[:success] = 'Usuário removido com sucesso.'
    redirect_to admin_department_members_path
  end

  private

  def set_department_role
    @department_role = DepartmentUser.find(params[:id])
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_department
    @department = Department.find(params[:department_id])
  end

  def department_roles_params
    params.require(:department_user).permit(:user_id, :department_id, :role_id)
  end

end
