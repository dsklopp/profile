# This is my core .bashrc file.  It simply sources the files
# I want to use.  

# My primary bash profile.  Wherever possible I keep all content
# in there.
source ~/.bash_danklopp
# Truly work specific items come next.
# Since I am a consultant I have one for each
# environment.  Since this bashrc file is shared publicly, all I
# will have here is a numerical listing of assignments, and none of
# the referenced files can be found outside of the assignment,
# nor is any name given.

if [ -f ~/.bash_assignment_1 ]; then
   source ~/.bash_assignment_1
fi
if [ -f ~/.bash_assignment_2 ]; then
   source ~/.bash_assignment_2
fi
if [ -f ~/.bash_assignment_3 ]; then
   source ~/.bash_assignment_3
fi
if [ -f ~/.bash_assignment_4 ]; then
   source ~/.bash_assignment_4
fi
