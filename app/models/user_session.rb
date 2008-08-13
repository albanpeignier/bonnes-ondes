class UserSession

  def initialize(session)
    @session = session
    @session[:rated_episodes_ids] ||= []
  end

  def rate_episode(episode)
    @session[:rated_episodes_ids] << episode.id
  end

  def can_rate_episode?(episode)
    not @session[:rated_episodes_ids].include? episode.id
  end

end
