class Staff::DepartmentsController < Staff::BaseController
  before_action :set_department, only: [ :show]
  before_action :set_user, only: [:index, :show]

  def index
    # @users = User.order(:name).page params[:page]
    @departments = @user.departments.page(params[:page]).per(12)
  end

  def show
  end

  def members
    @department = Department.find(params[:department_id])
    @members = @department.users.order(:name)
    @no_members = User.not_in(@department)
    @roles = Role.all
  end

  def add_member
    @department = Department.find(params[:department_id])
    member = @department.department_users.build(user_id: params[:member][:user],
                                                role_id: params[:member][:role])
    if member.save
      flash[:success] = "Membro adicionado com sucesso"
    else
      flash[:error] = "Problemas na adição"
    end
    redirect_to staff_department_members_path(@department)
  end

  def remove_member
    @department = Department.find(params[:department_id])
    member = @department.department_users.find_by_user_id(params[:user_id])
    if member.destroy
      flash[:success] = "Membro removido com sucesso"
    else
      flash[:error] = "Problemas na remoção"
    end
    redirect_to staff_department_members_path(@department)
  end

  private

  def set_user
    @user = current_user
  end

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :initials, :phone, :description, :local, :email)
  end
end