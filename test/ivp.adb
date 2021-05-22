with Ada.Text_IO;
with Synchronized_Output;
procedure Ivp is
begin
   for J in 1 .. 10 loop
      Synchronized_Output.Put_Line ("this is line" & J'Image);
   end loop;
   Ada.Text_IO.Put_Line ("done.");
   Synchronized_Output.Finalize;
end Ivp;
