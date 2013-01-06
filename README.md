# README

## Welcome to Holliday!

#### Requirements

* [Pandoc](http://johnmacfarlane.net/pandoc/)
* Bash
* Optional: Knowledge of Markdown
  * [Markdown Cheatsheet](http://support.mashery.com/docs/customizing_your_portal/Markdown_Cheat_Sheet)

Here's what Holliday is all about. DOCumentation.

All you have to do is:

    source holliday.sh
    start_holliday
    # # the h1-title of my doc
    # ## the h2-section title
    some_cmd
    some_other_cmd
    # **note**: this cmd is dangerous
    dangerous_cmd
    stop_holliday

And you'll get a nicely formatted document in any one of several output
formats.

#### A Holliday Session

    shalicke@shinobi holliday $ start_holliday 
    Welcome to Holliday. Doc will see you now.
    Currently only Markdown is supported.
    [doc]:shalicke@shinobi holliday $ # # How to use Holliday
    [doc]:shalicke@shinobi holliday $ # ## General Stuff
    [doc]:shalicke@shinobi holliday $ # * Start comments with a hash-space, then markdown syntax
    [doc]:shalicke@shinobi holliday $ # * all your regular commandlines (no markup) are wrapped as code
    [doc]:shalicke@shinobi holliday $ # * use 'stop_holliday' to stop
    [doc]:shalicke@shinobi holliday $ # * notice that the good Doc Holliday changes your prompt to [doc]:
    [doc]:shalicke@shinobi holliday $ whoami
    shalicke
    [doc]:shalicke@shinobi holliday $ some_long_command with some arguments
    bash: some_long_command: command not found
    [doc]:shalicke@shinobi holliday $ stop_holliday 
    You've just created a command line doc.
    What format would you like to export to?
    Enter a format name, or press enter for the default.
    Available formats are: 
    [rst|txt|html|xml|docx|markdown|textile] [html]
    html
    Enter an email to send your document to: 
    shalicke@gmail.com
    Enter a title for your document: 
    HollidayDemo
    Generating html document HollidayDemo (from /tmp/holliday-shalicke-1357477741.txt, as markdown) and sending to shalicke@gmail.com.
    /Users/shalicke/trib/holliday/HollidayDemo.html
    File generated: /Users/shalicke/trib/holliday/HollidayDemo.html

The contents of that document are as follows:

    <h1 id="how-to-use-holliday">How to use Holliday</h1>
    <h2 id="general-stuff">General Stuff</h2>
    <ul>
    <li><p>Start comments with a hash-space, then markdown syntax</p></li>
    <li><p>all your regular commandlines (no markup) are wrapped as code</p></li>
    <li><p>use 'stop_holliday' to stop</p></li>
    <li><p>notice that the good Doc Holliday changes your prompt to [doc]:</p></li>
    </ul>
    <p><code>whoami</code></p>
    <p><code>some_long_command with some arguments</code></p>

Neat!
