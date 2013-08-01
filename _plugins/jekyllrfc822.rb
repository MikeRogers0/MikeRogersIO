# Format a date in rfc822 format e.g. "Wed, 02 Oct 2002 15:00:00 +0200"
#
# date - The Time to format.
#
# From: https://gist.github.com/jazzgumpy/3040692
# Returns the formatted String.
def date_to_rfc822(date)
  date.strftime("%a, %d %b %Y %H:%M:%S %z")
end