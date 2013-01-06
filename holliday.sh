#!/bin/bash

# holliday.sh is a companion script to holliday.py.
# Holliday is a system for quickly generating documentation as you
# work on the command line.

function start_holliday () {

  echo "Welcome to Holliday. Doc will see you now."
  echo "What format would you like to work in?"
  echo "Sensible formats are:"
  echo "[rst|markdown|textile|txt] [markdown] "
  read $_DOC_INPUT_FORMAT
  export $_DOC_INPUT_FORMAT

  # capture original prompt
  export _DOC_ORIGINAL_PS1="$PS1"
  PS1="[doc]:$PS1"
 
  # history turned off in noninteractive
  HISTFILE="$HOME/.bash_history"
  set -o history

  export _DOC_HISTORY_START="$(history | awk '{print $1}' | tail -n1)"
  export _DOC_TMPDIR="/tmp"
}

function stop_holliday () {
  export PS1="$_DOC_ORIGINAL_PS1"

  HISTFILE="$HOME/.bash_history"
  set -o history

  CMDS="$(fc -l $_DOC_HISTORY_START | awk '{for (i=2; i<=NF; i++) print $i}')"

  DATESTRING=$(date +'%s')
  export _DOC_FILENAME="$TMPDIR/holliday-${USER}-${DATESTRING}.txt"
  echo "$CMDS" >> "$TMPDIR/holliday-${USER}-${DATESTRING}.txt"
  sed -i -e 's/^(\w)/^\t$1/' $_DOC_FILENAME

  doc_prompt
}

function doc_capture () {
  echo ""
}

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
  doc_generate
  }

function doc_generate() {
  
  echo "Generating $DOC_OUTPUT_FORMAT document $_DOC_TITLE (from $_DOC_FILENAME, as $_DOC_INPUT_FORMAT) and sending to $_DOC_EMAIL." 

  PANDOC_FILE="${PWD}/${_DOC_TITLE}.${_DOC_OUTPUT_FORMAT}"
  pandoc -f ${_DOC_INPUT_FORMAT} -o ${PANDOC_FILE}

  if [[ $? == 0 ]]; then
    echo "File generated: ${PANDOC_FILE}"
  fi

  mail -s "Your documentation: ${_DOC_TITLE}" < ${PANDOC_FILE}
}
