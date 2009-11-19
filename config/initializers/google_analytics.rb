Rubaidh::GoogleAnalytics.default_account = Rubaidh::GoogleAnalytics.new('UA-1896598-5').tap do |account|
  # Use domain "none" to track all domains managed by bonnes-ondes
  # http://www.google.com/support/analytics/bin/answer.py?answer=55503
  account.domain_name = "none"
end
Rubaidh::GoogleAnalytics.environments = ['production']
