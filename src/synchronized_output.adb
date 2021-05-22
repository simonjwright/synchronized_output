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

with Ada.Characters.Latin_1;
with Ada.Containers.Synchronized_Queue_Interfaces;
with Ada.Containers.Unbounded_Synchronized_Queues;
with Ada.Strings.Unbounded;
with Ada.Text_IO;
with System;

package body Synchronized_Output is

   package Queue_Interfaces
   is new Ada.Containers.Synchronized_Queue_Interfaces
     (Element_Type => Ada.Strings.Unbounded.Unbounded_String);

   package Queues is new Ada.Containers.Unbounded_Synchronized_Queues
     (Queue_Interfaces => Queue_Interfaces);

   Q : Queues.Queue;

   Quit : Boolean := False;

   procedure Put_Line (S : String) is
   begin
      Q.Enqueue (Ada.Strings.Unbounded.To_Unbounded_String
                   (S & Ada.Characters.Latin_1.LF));
   end Put_Line;

   procedure Finalize is
   begin
      Put_Line ("Peak message queue length:" & Q.Peak_Use'Image);
      Quit := True;
   end Finalize;

   task Reporter with Priority => System.Priority'First;

   task body Reporter is
      Item : Ada.Strings.Unbounded.Unbounded_String;
   begin
      Printing : loop
         select
            Q.Dequeue (Item);
            Ada.Text_IO.Put (Ada.Strings.Unbounded.To_String (Item));
         else
            exit Printing when Quit;
            delay 0.1;
         end select;
      end loop Printing;
   end Reporter;

end Synchronized_Output;
