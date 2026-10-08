package Sokol_FSM with
  SPARK_Mode     => On,
  Abstract_State => State
is

   type Main_State is (Init, Operational, Emergency_Isolation);
   type Sub_State  is (Idle_Monitoring, Active_Filtering, Degraded_Bypass);

   type Interface_Id is range 1 .. 4;
   type Interface_State is (Iface_Down, Iface_Active, Iface_Isolated);
   type Interface_Array is array (Interface_Id) of Interface_State;

   type Pipeline_Stage is (Ingress_eBPF, Anomaly_Check, Hardware_Drop, Forwarded);
   type Packet_Pipeline is record
      Stage   : Pipeline_Stage := Ingress_eBPF;
      Dropped : Boolean        := False;
   end record;

   type Node_Role is (Primary_Leader, Secondary_Standby, Isolated_Node);
   type Cluster_Node is record
      Role       : Node_Role := Secondary_Standby;
      Health_OK  : Boolean   := True;
      Peer_Alive : Boolean   := True;
   end record;

   type System_Context is record
      Main    : Main_State      := Init;
      Sub     : Sub_State       := Idle_Monitoring;
      Ifaces  : Interface_Array := (others => Iface_Down);
      Cluster : Cluster_Node;
   end record;

   function Get_Main_State return Main_State;
   function Get_Sub_State return Sub_State;
   function Get_Iface_State (I : Interface_Id) return Interface_State;
   function Get_Cluster_Role return Node_Role;
   function Get_Cluster_Health return Boolean;
   function Get_Cluster_Peer_Alive return Boolean;


   procedure Set_Hierarchical_State (M : in Main_State; S : in Sub_State)
   with
     Global => (In_Out => State),
     Pre    => (if M /= Operational then S = Idle_Monitoring),
     Post   => Get_Main_State = M and then Get_Sub_State = S;

   
   procedure Enforce_Global_Lockdown
   with
     Global => (In_Out => State),
     Post   => Get_Main_State = Emergency_Isolation
               and then (for all I in Interface_Id => Get_Iface_State (I) = Iface_Isolated);

   
   procedure Advance_Pipeline (P : in out Packet_Pipeline)
   with
     Pre  => not P.Dropped and P.Stage /= Forwarded and P.Stage /= Hardware_Drop,
     Post => (if P.Stage'Old = Ingress_eBPF then P.Stage = Anomaly_Check
              elsif P.Stage'Old = Anomaly_Check then P.Stage = Forwarded);


   procedure Evaluate_Quorum
   with
     Global => (In_Out => State),
     Post   => (if not Get_Cluster_Health then Get_Cluster_Role = Isolated_Node
                elsif not Get_Cluster_Peer_Alive then Get_Cluster_Role = Primary_Leader);

private


   Current_Ctx : System_Context with Part_Of => State;

   function Get_Main_State return Main_State is (Current_Ctx.Main);
   function Get_Sub_State return Sub_State is (Current_Ctx.Sub);
   function Get_Iface_State (I : Interface_Id) return Interface_State is (Current_Ctx.Ifaces (I));
   function Get_Cluster_Role return Node_Role is (Current_Ctx.Cluster.Role);
   function Get_Cluster_Health return Boolean is (Current_Ctx.Cluster.Health_OK);
   function Get_Cluster_Peer_Alive return Boolean is (Current_Ctx.Cluster.Peer_Alive);

end Sokol_FSM;