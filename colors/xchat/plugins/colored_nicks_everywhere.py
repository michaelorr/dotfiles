import xchat
import re

__module_name__ = "colored_nicks_everywhere"
__module_version__ = "0.6"
__module_description__ = "Colors nicks in messages with the same color X-Chat uses to display nicks"

# Load this script into X-Chat with: /py load <path_to>/colored_nicks_everywhere.py

normal_color = ""   # Adjust this if you display messages with a different color
#normal_color = "16"   # My config displays "Channel Message"s in bright-white

userList = []   # A cache of seen nicks (actually a queue of least-to-most-recent speakers).

# For stripping colors from a string
colorRe = re.compile(r"(||[0-9]{1,2}(,[0-9]{1,2}|))")
# For finding words in the message that could be a nick
nickRe = re.compile(r"[A-Za-z0-9_|/`'^\-\[\]\\]+")

def check_message(word, word_eol, userdata):
	nick_with_color = word[0]
	line_with_color = word[1]
	nick = colorRe.sub("",nick_with_color)
	line = colorRe.sub("",line_with_color)

	# Maintain userList
	if nick in userList:
		userList.remove(nick)
	if len(userList) > 200:
		del userList[0]
	userList.append(nick)

	# We do not do anything with lines which already contain color-codes.
	# This is important to avoid infinitely re-processing the message!  See below.
	if line != line_with_color:
		return xchat.EAT_NONE

	# I was using xchat.get_list("users") here to get an up-to-date userlist for
	# the channel, but it caused a memory leak!  (X-Chat 2.8.6-2.1)

	# Iterate through all nick-like words in the message
	# Build up newLine along the way
	iterator = nickRe.finditer(line)
	newLine = ""
	reached = 0   # How much of the input string we have copied so far
	for match in iterator:
		word = match.group()
		# Check if the word is actually a user in the channel
		if word in userList:
			col = color_of(word)
			newWord = "" + str(col) + word + normal_color
			newLine = newLine + line[reached:match.span()[0]] + newWord
			reached = match.span()[1]
	newLine = newLine + line[reached:len(line)]

	newLineWithoutColor = colorRe.sub("",newLine)
	if (newLineWithoutColor == newLine or newLine == line_with_color):
		# If we didn't adjust the line, then there is no need to re-emit it.
		return xchat.EAT_NONE
	else:
		# Warning: This will get re-checked by check_message()!  But it should
		# reject it next time because now the line contains color codes.
		xchat.emit_print("Channel Message", nick, newLine)
		return xchat.EAT_ALL

# A copy of the function from X-Chat:
rcolors = [ 19, 20, 22, 24, 25, 26, 27, 28, 29 ]
def color_of(nick):
	i=0
	sum=0
	while i<len(nick):
		c = nick[i]
		sum += ord(c)
		sum %= len(rcolors)
		i += 1
	return rcolors[sum]

xchat.hook_print("Channel Message", check_message)

print "Loaded "+__module_name__+" v"+__module_version__

