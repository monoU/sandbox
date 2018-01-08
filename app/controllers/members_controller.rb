class MembersController < InheritedResources::Base

  private

    def member_params
      params.require(:member).permit(:name, :user_name, :age, :address, :email, :phone)
    end
end

