# http://ruby-doc.org/core-2.0/Time.html#method-i-strftime
# We need to restart the server every time we modify this
formats = {
    #:default => "%a, %b %e at %l:%M%P", # Mon, Oct 4 at 7:00pm
    :label => "%A, %-m/%-d/%Y",
    :date_time12 => "%m/%d/%Y %I:%M%p",
    :month_day_at_time => "%B %d at %I:%M%p",
    :month_only => "%B",
    :month_day => "%B %d", # October 07 (zero padded)
    :month_day2 => "%B %e", # October 7 (blank padded)
    :mnth_day => "%b %d", # Oct 17
    :month_year => "%B %Y", # October 2010,
    :month_day_year => "%B %d, %Y", # October 12, 2010
    :pretty => "%a, %b %e at %l:%M%P", # Mon, Oct 4 at 7:00pm
    :full => "%a, %B %e, %l:%M%P", # Mon, October 4 at 7:00pm
    :specific => "%A, %b %d, %Y",
    :time_only => "%l:%M %P", # 7:00pm
    :quick => "%b %e, %l:%M%p", # Oct 4, 7:00pm
    :american => "%m/%d/%Y", # 09/13/2012
    :american_short => "%m/%d", # 09/13/2012
    :colloquial => '%A, %B %e',
    :colloquial_short => '%a, %b %e',
    :brief => "%b %e", # Mar 13
    :dashes => "%m-%d-%Y"
}

Time::DATE_FORMATS.merge! formats
Date::DATE_FORMATS.merge! formats
