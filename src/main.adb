with Ada.Text_IO; use Ada.Text_IO;
with Sokol_FSM;  use Sokol_FSM;

procedure Main with SPARK_Mode => Off is
   P : Packet_Pipeline;
begin
   Put_Line ("[Sokol SPARK Engine] Initializing state machine...");
   Set_Hierarchical_State (Operational, Active_Filtering);
   Put_Line ("[Sokol SPARK Engine] Current Main State: " & Get_Main_State'Image);

   Put_Line ("[Sokol SPARK Engine] Advancing Packet Pipeline...");
   Advance_Pipeline (P);
   Put_Line ("[Sokol SPARK Engine] Pipeline Stage: " & P.Stage'Image);

   Put_Line ("[Sokol SPARK Engine] Executing Emergency Lockdown...");
   Enforce_Global_Lockdown;
   Put_Line ("[Sokol SPARK Engine] Current Main State: " & Get_Main_State'Image);
end Main;