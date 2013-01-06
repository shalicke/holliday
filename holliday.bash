#!/bin/bash

# Holliday is a system for quickly generating documentation as you
# work on the command line. You simply do what you're doing, every so often
# you can put in a comment in markdown format explaining what you're doing.

# actual command lines are converted into markdown code blocks. 

function start_holliday () {
  
  _DOC_INPUT_FORMAT="markdown"
  
  echo "Welcome to Holliday. Doc will see you now."
  echo "Currently only Markdown is supported."
  # TODO: add more sources

  # capture original prompt
  export _DOC_ORIGINAL_PS1="$PS1"
  PS1="[doc]:$PS1"
 
  # history turned off in noninteractive
  HISTFILE="$HOME/.bash_history"
  set -o history

  export _DOC_HISTORY_START="$(history | awk '{print $1}' | tail -n1)"
  _DOC_HISTORY_START=`expr $_DOC_HISTORY_START + 1`

  export _DOC_TMPDIR="/tmp"
}

function stop_holliday () {
  export PS1="$_DOC_ORIGINAL_PS1"

  HISTFILE="$HOME/.bash_history"
  set -o history

  CMDS="$(fc -l $_DOC_HISTORY_START | awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}')"

  DATESTRING=$(date +'%s')
  export _DOC_FILENAME="$_DOC_TMPDIR/holliday-${USER}-${DATESTRING}.txt"
  echo "$CMDS" >> "$_DOC_TMPDIR/holliday-${USER}-${DATESTRING}.txt"

  # a little data organization
  perl -i -pe 's/^# //g;' $_DOC_FILENAME
  perl -i -pe 's/^(\w.*)/```$1```/g' $_DOC_FILENAME
  perl -i -pe 's/(.*)$/$1\n/;' $_DOC_FILENAME

  doc_prompt
}

# TODO: optionally capture output
#function doc_capture () {
  #echo ""
#}

function doc_prompt () {
  echo "You've just created a command line doc."
  echo "What format would you like to export to?"
  echo "Enter a format name, or press enter for the default."
  echo "Available formats are: "
  echo "[rst|txt|html|xml|docx|markdown|textile] [html]"
  read _DOC_OUTPUT_FORMAT
  echo "Enter an email to send your document to: "
  read _DOC_TO_EMAIL
  echo "Enter a title for your document: "
  read _DOC_TITLE
  export _DOC_TITLE 
  export _DOC_OUTPUT_FORMAT 
  export _DOC_TO_EMAIL
  doc_generate
  }

function doc_generate() {
  
  echo "Generating $_DOC_OUTPUT_FORMAT document $_DOC_TITLE (from $_DOC_FILENAME, as $_DOC_INPUT_FORMAT) and sending to $_DOC_TO_EMAIL." 

  PANDOC_FILE="${PWD}/${_DOC_TITLE}.${_DOC_OUTPUT_FORMAT}"
  echo $PANDOC_FILE
  pandoc -f ${_DOC_INPUT_FORMAT} ${_DOC_FILENAME} -o ${PANDOC_FILE}

  if [[ $? == 0 ]]; then
    echo "File generated: ${PANDOC_FILE}"
    mail -s "Your documentation: ${_DOC_TITLE}" ${_DOC_TO_EMAIL} < ${PANDOC_FILE}
  fi
  doc_cleanup
}

function doc_cleanup () {
  unset _DOC_TITLE
  unset _DOC_OUTPUT_FORMAT
  unset _DOC_INPUT_FORMAT
  unset _DOC_FILENAME
  unset _DOC_TO_EMAIL
  unset _DOC_TMPDIR
  unset _DOC_ORIGINAL_PS1
  unset _DOC_HISTORY_START
}

