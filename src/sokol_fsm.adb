package body Sokol_FSM with
  SPARK_Mode    => On,
  Refined_State => (State => Current_Ctx)
is

   procedure Set_Hierarchical_State (M : in Main_State; S : in Sub_State) is
   begin
      Current_Ctx.Main := M;
      Current_Ctx.Sub  := S;
   end Set_Hierarchical_State;

  
   procedure Enforce_Global_Lockdown is
   begin
      Current_Ctx.Main         := Emergency_Isolation;
      Current_Ctx.Immune.Phase := Apoptosis_Quarantine;

      for I in Interface_Id loop
         Current_Ctx.Ifaces (I) := Iface_Isolated;
         pragma Loop_Invariant
           (for all J in Interface_Id'First .. I => Current_Ctx.Ifaces (J) = Iface_Isolated);
      end loop;
   end Enforce_Global_Lockdown;

   procedure Advance_Pipeline (P : in out Packet_Pipeline) is
   begin
      case P.Stage is
         when Ingress_eBPF  => P.Stage := Anomaly_Check;
         when Anomaly_Check => P.Stage := Forwarded;
         when Hardware_Drop | Forwarded => null;
      end case;
   end Advance_Pipeline;

   procedure Evaluate_Quorum is
   begin
      if not Current_Ctx.Cluster.Health_OK then
         Current_Ctx.Cluster.Role := Isolated_Node;
      elsif not Current_Ctx.Cluster.Peer_Alive then
         Current_Ctx.Cluster.Role := Primary_Leader;
      end if;
   end Evaluate_Quorum;

   
   procedure Trigger_Immune_Response (Load : in Stress_Level) is
   begin
      Current_Ctx.Immune.System_Stress := Load;

      if Load >= 80 then
         Current_Ctx.Immune.Phase := Active_Neutralization;
      elsif Load >= 30 then
         Current_Ctx.Immune.Phase := Inflammatory_Alert;
      else
         Current_Ctx.Immune.Phase := Homeostatic_Rest;
      end if;
   end Trigger_Immune_Response;


   procedure Transition_To_Refractory is
   begin
      Current_Ctx.Immune.Phase         := System_Refractory;
      Current_Ctx.Immune.System_Stress := 0;
   end Transition_To_Refractory;

end Sokol_FSM;