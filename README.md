# Sokol FSM (SPARK Core) 🦅🧬

> **Formally Verified, Biomimetic Multi-Topology Finite State Machine in Ada/SPARK**

**Sokol FSM** is a mathematically proven state control core designed around the principles of **biomimetics and digital organisms**. The module functions as the Central Nervous System (CNS) and Immune System for the broader Sokol / Trinity ecosystem (eBPF, Rust, Zig DB, Hardware Filters).

Built with **Ada/SPARK 2014** at verification level `--level=2`, the core guarantees the Absence of Run-Time Errors (**AoRTE**), strictly enforces state invariants, and protects the system against DoS exhaustion and split-brain desynchronization.

---

## 🏛️ Architecture & Biomimetic Topologies

The system unifies 5 interconnected topologies inspired by biological mechanisms:

1. **Hierarchical Topology (Central Nervous System / CNS):**
   * Controls global life-cycle phases (`Init`, `Operational`, `Emergency_Isolation`).
2. **Peripheral Topology (Network Receptors / Interfacing):**
   * Handles independent monitoring and physical/virtual interface isolation (`Iface_Down`, `Iface_Active`, `Iface_Isolated`).
3. **Pipeline Topology (Reflex Arc):**
   * Processes kernel-space packets via eBPF probes with sequential state validation.
4. **Cluster Topology (Node Symbiosis / High Availability):**
   * Manages quorum and network node roles (`Primary_Leader`, `Secondary_Standby`, `Isolated_Node`).
5. **Immunological Topology (Immune Response & Homeostasis):**
   * **`Homeostatic_Rest`**: Healthy resting baseline state.
   * **`Inflammatory_Alert`**: Inflammatory response and elevated readiness upon anomaly detection (Stress Load $\ge 30\%$).
   * **`Active_Neutralization`**: Active attack suppression and anomalous traffic filtering (Stress Load $\ge 80\%$).
   * **`System_Refractory`**: Mandatory recovery period to restore resources and prevent autoimmune exhaustion.
   * **`Apoptosis_Quarantine`**: Controlled apoptosis (isolation of infected tissue/node) during Global Lockdown enforcement.

---

## 🔗 Integration with HSP (Heterogeneous State Protocol)

Sokol FSM seamlessly integrates with the **HSP** protocol to ensure atomic synchronization across heterogeneous nodes:

* **eBPF (Kernel Layer):** Instant $O(1)$ reflex drop of malicious packets.
* **SPARK Core (Brain Layer):** Single Source of Truth that mathematically proves assumptions and executes global isolation decisions.
* **Rust / Zig Orchestrator:** Propagates state epoch data and Vector Clocks via Zero-Copy Shared Memory.

---

## 🛠️ Prerequisites & Toolchain

To build and formally verify the codebase, you need:

* **[Alire](https://alire.ada.dev/)** (Ada Package Manager) >= 2.0
* **GNAT Native Toolchain** (GCC for Ada)
* **SPARK 2014 Toolchain** (`gnatprove`)

---

## 🚀 Quickstart

### 1. Clone the repository
```bash
git clone https://github.com/ValkyrieSentinel/sokol-fsm-spark.git
cd sokol-fsm-spark

### 2. Configure SPARK Toolchain (One-time setup)
Ensure gnatprove is available in your $PATH. If SPARK is installed locally:

```bash
echo 'export PATH="$HOME/.local/spark/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

### 3. Run Formal Verification (gnatprove)
Verify all contracts, preconditions, and postconditions at --level=2:

```bash
gnatprove -P sokol_fsm.gpr --level=2

Expected output: 100% proved invariants, zero out-of-bounds array accesses, and no unreachable code.

### 4. Build and Run Unit Tests

```bash
alr build
./obj/main

### 🔬 Project Structure
Plaintext
sokol-fsm-spark/
├── sokol_fsm.gpr         # GNAT Project File
├── alire.toml            # Alire Manifest
├── src/
│   ├── sokol_fsm.ads     # FSM Specification, SPARK Contracts & Types
│   ├── sokol_fsm.adb     # FSM Body with Loop Invariants & Implementation
│   └── main.adb          # Test Suite using pragma Assert
└── README.md             # Project Documentation


### 🛡️ License
Distributed under the MIT License.

Developed by ValkyrieSentinel.


