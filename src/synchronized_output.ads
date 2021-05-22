--  Copyright Simon Wright <simon@pushface.org>

--  This package is free software; you can redistribute it and/or
--  modify it under terms of the GNU General Public License as
--  published by the Free Software Foundation; either version 3, or
--  (at your option) any later version.  This package is distributed
--  in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--  without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
--  more details.  You should have received a copy of the GNU General
--  Public License distributed with this package; see file COPYING3.
--  If not, go to http://www.gnu.org/licenses for a complete copy of
--  the license.

--  This package supports logging messages.
--
--  There are two problems addressed:
--
--  (1) If multiple tasks are generating output, lines might get
--  mingled. Here, each line is output separately.
--
--  (2) Outputting the text might interfere with application
--  timing. Here, text is output at lowest task priority.

package Synchronized_Output is

   --  Output S, followed by a newline, to standard output.
   procedure Put_Line (S : String);

   --  Called at end of operations to flush and terminate the inner
   --  task.
   procedure Finalize;

end Synchronized_Output;
