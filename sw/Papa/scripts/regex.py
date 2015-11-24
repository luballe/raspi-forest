import re
import sys

prog = re.compile('(\d{4})-(\d{1,2})-(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})')

while True:
  line = sys.stdin.readline()
  if not line: break

  if prog.match(line):
    print 'matched'
  else:
    print 'not matched'
