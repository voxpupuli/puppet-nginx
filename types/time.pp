# @summary The specification of a time in nginx configs
#
# Time intervals can be specified in milliseconds, seconds, minutes, hours, days and so on, using the following suffixes:
#
# Suffix | Unit
# -------|-----
# ms     | milliseconds
# s      | seconds
# m      | minutes
# h      | hours
# d      | days
# w      | weeks
# M      | months, 30 days
# y      | years, 365 days
#   
# Multiple units can be combined in a single value by specifying them in the
# order from the most to the least significant, and optionally separated by
# whitespace. For example, "1h 30m" specifies the same time as "90m" or
# "5400s". A value without a suffix means seconds. It is recommended to
# always specify a suffix.
# 
# Some of the time intervals can be specified only with a seconds resolution. 
#
# @see https://nginx.org/en/docs/syntax.html
type Nginx::Time = Pattern[/^((\d+y)?\s?(\d+M)?\s?(\d+w)?\s?(\d+d)?\s?(\d+h)?\s?(\d+m)?\s?(\d+s)?\s?(\d+ms)?\s?|\d+)$/]
