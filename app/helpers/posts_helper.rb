module PostsHelper
    def translated_sharable sharable 
        if sharable.class == Game 
            "game"
        elsif sharable.class == Article 
            "bài viết"
        else 
            "nội dung"
        end
    end
    def sharable_url_for sharable
        if sharable.is_a? Game
            game_path(sharable.id)
        elsif sharable.is_a? Article
            article_path(sharable.id)
        end
    end

    def is_you? user 
        user.id == current_user&.id 
    end
end
