module ApplicationHelper
  def season(date=Date.today)
    return :summer if date >= Date.strptime("01-Apr-#{Date.today.year.to_s[2..4]}", "%d-%b-%y") and
                      date <= Date.strptime("31-Oct-#{Date.today.year.to_s[2..4]}", "%d-%b-%y")

    return :winter_b_ny if date >= Date.strptime("01-Nov-#{Date.today.year.to_s[2..4]}", "%d-%b-%y") and
                           date <= Date.strptime("31-Dec-#{(Date.today.year + 1).to_s[2..4]}}", "%d-%b-%y")

    return :winter_a_ny if date >= Date.strptime("01-Jan-#{Date.today.year.to_s[2..4]}", "%d-%b-%y") and
                           date <= Date.strptime("31-Mar-#{Date.today.year.to_s[2..4]}", "%d-%b-%y")
  end

  def summer_dates(date=Date.today)
    return ["01-Apr-#{Date.today.year.to_s[2..4]}", "31-Oct-#{Date.today.year.to_s[2..4]}"] if season(date) == :summer or season(date) == :winter_a_ny
    return ["01-Apr-#{(Date.today.year + 1).to_s[2..4]}", "31-Oct-#{(Date.today.year + 1).to_s[2..4]}"] if season(date) == :winter_b_ny
  end

  def winter_dates(date=Date.today)
    return ["01-Nov-#{Date.today.year.to_s[2..4]}", "31-Mar-#{(Date.today.year + 1).to_s[2..4]}"] if season(date) == :summer or season(date) == :winter_b_ny
    return ["01-Jan-#{Date.today.year.to_s[2..4]}", "31-Mar-#{Date.today.year.to_s[2..4]}"] if season(date) == :winter_a_ny
  end
end
