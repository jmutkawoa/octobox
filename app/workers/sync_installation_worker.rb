# frozen_string_literal: true

class SyncInstallationWorker
  include Sidekiq::Worker
  sidekiq_options queue: :sync_subjects, unique: :until_and_while_executing

  def perform(payload)
    app_installation = AppInstallation.create(AppInstallation.map_from_api(payload['installation']))

    app_installation.add_repositories(payload['repositories'])
  end
end
