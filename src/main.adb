with Ada.Text_IO; use Ada.Text_IO;
with Sokol_FSM;  use Sokol_FSM;

procedure Main with SPARK_Mode => Off is
   P : Packet_Pipeline;

   procedure Run_Tests is
   begin
      -- Test 1: Init & CNS
      Set_Hierarchical_State (Operational, Active_Filtering);
      pragma Assert (Get_Main_State = Operational);
      pragma Assert (Get_Sub_State = Active_Filtering);
      pragma Assert (Get_Immune_Phase = Homeostatic_Rest);

      -- Test 2: Reflex Pipeline
      Advance_Pipeline (P);
      pragma Assert (P.Stage = Anomaly_Check);

      -- Test 3: Immune Reaction Levels
      Trigger_Immune_Response (40);
      pragma Assert (Get_Immune_Phase = Inflammatory_Alert);
      pragma Assert (Get_System_Stress = 40);

      Trigger_Immune_Response (85);
      pragma Assert (Get_Immune_Phase = Active_Neutralization);
      pragma Assert (Get_System_Stress = 85);

      -- Test 4: Refractory Recovery
      Transition_To_Refractory;
      pragma Assert (Get_Immune_Phase = System_Refractory);
      pragma Assert (Get_System_Stress = 0);

      -- Test 5: Global Lockdown / Apoptosis
      Enforce_Global_Lockdown;
      pragma Assert (Get_Main_State = Emergency_Isolation);
      pragma Assert (Get_Immune_Phase = Apoptosis_Quarantine);
      for I in Interface_Id loop
         pragma Assert (Get_Iface_State (I) = Iface_Isolated);
      end loop;

      Put_Line ("All unit tests passed successfully.");
   end Run_Tests;

begin
   Put_Line ("Running Sokol FSM sanity checks...");
   Run_Tests;
end Main;