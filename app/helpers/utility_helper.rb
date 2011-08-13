module UtilityHelper
  def format_url(url)
    rewrited_url = url.gsub(/\(/,'a')
                      .gsub(/\)/,'a')
                      .gsub(/[\+\s\/]/,'-')
                      .gsub(/-+/,'-')
  end
end
