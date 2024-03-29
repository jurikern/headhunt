require 'active_support/concern'

module AuthorizeBehavior
  extend ActiveSupport::Concern

  included do
    class_eval do

      def self.find_first_by_auth_conditions(warden_conditions)
        conditions = warden_conditions.dup
        if login = conditions.delete(:login)
          where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
        else
          where(conditions).first
        end
      end

      def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
        provider_name, uid, email, username = auth.provider, auth.uid, auth.info.email, auth.info.nickname
        User.find_or_create_and_confirm_by(provider_name, uid, email, username, signed_in_resource)
      end

      def self.find_for_google_oauth2(auth, signed_in_resource=nil)
        provider_name, uid, email = auth.provider, auth.uid, auth.info.email
        User.find_or_create_and_confirm_by(provider_name, uid, email, nil, signed_in_resource)
      end

      def self.find_for_linkedin_oauth(auth, signed_in_resource=nil)
        provider_name, uid, email = auth.provider, auth.uid, auth.info.email
        User.find_or_create_and_confirm_by(provider_name, uid, email, nil, signed_in_resource)
      end

      def self.find_for_github_oauth(auth, signed_in_resource=nil)
        provider_name, uid, email, username = auth.provider, auth.uid, auth.info.email, auth.info.nickname
        User.find_or_create_and_confirm_by(provider_name, uid, email, username, signed_in_resource)
      end

      def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
        provider_name, uid, username = auth.provider, auth.uid, auth.info.nickname
        User.find_or_create_and_confirm_by(provider_name, uid, nil, username, signed_in_resource)
      end

      protected

      def self.find_or_create_and_confirm_by(provider_name, uid, email = nil, username = nil, signed_in_resource = nil)
        provider = Provider.where(name: provider_name, uid: uid).first
        user     = nil

        unless provider
          User.transaction do
            user = username.nil? ? User.find_by_email(email) : User.find_by_username(username)

            if user.nil?
              if signed_in_resource.nil?
                user = User.new({
                    username: User.generate_random_username(username),
                    email:    email.nil? ? User.generate_random_email : email,
                    password: Devise.friendly_token[4,20]
                })
                user.skip_confirmation!
                user.save!
              else
                user = signed_in_resource
              end
            end

            similar_provider = user.providers.where(name: provider_name).first
            if similar_provider.nil?
              user.providers.create!(
                  name: provider_name,
                  uid:  uid
              )
            else
              similar_provider.update_attributes!({
                  uid: uid
              })
            end

          end
        else
          user = provider.user
        end
        user
      end

      def self.generate_random_email
        random_email = "user.#{Random.rand(99999999)}@headhunt.ee"
        return random_email unless User.exists?(email: random_email)
        User.generate_random_email
      end

      def self.generate_random_username(username = nil)
        random_username = username || "user.#{Random.rand(99999999)}"
        return random_username unless User.exists?(username: random_username)
        User.generate_random_username(nil)
      end

    end
  end
end