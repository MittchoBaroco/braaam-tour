module ApplicationHelper
  def summer_dates(date=Date.today)
    return ["01-Apr-#{Date.today.year.to_s[2..4]}", "30-Oct-#{Date.today.year.to_s[2..4]}"] if season(date) == :summer
    return ["01-Apr-#{(Date.today.year + 1).to_s[2..4]}", "30-Oct-#{(Date.today.year + 1).to_s[2..4]}"] if season(date) == :winter
  end

  def winter_dates(date=Date.today)
    return ["01-Nov-#{Date.today.year.to_s[2..4]}", "30-Mar-#{(Date.today.year + 1).to_s[2..4]}"]
  end

  def season(date=Date.today)
    return :summer if date >= Date.strptime("01-Apr-#{Date.today.year.to_s[2..4]}", "%d-%b-%y") and date <= Date.strptime("30-Oct-#{Date.today.year.to_s[2..4]}", "%d-%b-%y")
    return :winter if date >= Date.strptime("01-Nov-#{Date.today.year.to_s[2..4]}", "%d-%b-%y") and date <= Date.strptime("30-Mar-#{((Date.today.year) + 1).to_s[2..4]}", "%d-%b-%y")
  end
end
