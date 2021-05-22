# Synchronized Output #

This package supports logging messages.

There are two problems addressed:

* If multiple tasks are generating output, lines might get mingled. Here, each line is output separately.
*  Outputting the text might interfere with application timing. Here, text is output at lowest task priority.

Note, procedure `Finalize` must be called at program end to flush text and terminate the inner task (otherwise, your program will hang waiting for the inner task to terminate).
