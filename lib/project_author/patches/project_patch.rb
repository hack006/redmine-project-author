module RedmineProjectAuthor
  module Patches
    # Path project - add project author association
    module ProjectPatch

      def self.included(base) # :nodoc:
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development
          belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'

          # Selected user has to be valid
          validate do |project|
            user_ids = User.all.map { |u| u.id }
            user_ids << nil
            errors.add(:author, I18n.t('author_must_exist_in_system')) unless user_ids.include? project.author_id
          end

          # Enable passing author_id parameter
          Project.safe_attributes 'author_id'
        end
      end
      
    end
  end
end
