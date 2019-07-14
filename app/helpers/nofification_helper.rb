module NofificationHelper
    def you_did_it_yourself? activity 
        current_user.id == activity.user.id #&& activity.user.id == activity.target_id
    end
end
