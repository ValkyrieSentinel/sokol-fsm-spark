# Sokol FSM SPARK 🛡️

[![SPARK 2014](https://img.shields.io/badge/SPARK-2014_Level_2-brightgreen.svg)](https://learn.adacore.com/)
[![Formal Verification](https://img.shields.io/badge/Verification-100%25_Proved-success.svg)](#formal-verification-guarantees)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**Sokol FSM** is a formally verified Finite State Machine (FSM) core written in **Ada/SPARK 2014**, designed for high-throughput network security infrastructure, eBPF orchestrators, and custom firewalls.

The primary objective of this project is to mathematically guarantee the **Absence of Run-Time Errors (AoRTE)** and enforce strict system safety invariants during critical security events.

---

## 🏛️ Multi-Topology Architecture

The project implements and formally verifies **4 fundamental architectural FSM topologies** within a single encapsulated global context:

1. **Hierarchical (Nested States):** Manages high-level system states (`Init`, `Operational`, `Emergency_Isolation`) and their operational sub-states (`Active_Filtering`, `Degraded_Bypass`).
2. **Parallel (Per-Interface Array):** Atomic status control over an array of network interfaces (`Interface_Id 1..4`), enabling parallel isolation across all ports.
3. **Pipeline Processing Stage:** Models sequential packet inspection stages (`Ingress_eBPF` → `Anomaly_Check` → `Forwarded` / `Hardware_Drop`).
4. **HA Quorum Clustering:** High-availability mechanism and Split-Brain protection for cluster nodes (`Primary_Leader`, `Secondary_Standby`, `Isolated_Node`).

---

## 🔬 Formal Verification Guarantees

Formal verification is carried out using `gnatprove` at `--level=2`, leveraging automated SMT solvers (Z3, CVC4, Alt-Ergo).

### Formally Proven Guarantees (100% Green Proofs):
* **Data & Flow Dependencies:** Complete absence of side effects, no uninitialized memory reads, and strictly encapsulated `Global` contracts.
* **Termination (`Always_Terminates`):** Proven that all state getters and transition procedures strictly terminate in finite time.
* **Safety Invariants (`for all` Quantification):** Proven that `Enforce_Global_Lockdown` atomically transitions **all** network interfaces into the `Iface_Isolated` state without exception, guaranteed by `Loop_Invariant`.
* **Pipeline Integrity:** Proven that unverified or dropped packets can never reach the `Forwarded` state.

---

## 🛠️ Toolchain & Requirements

* **GNAT / Ada Compiler:** 14.1.3 or newer
* **GPRbuild:** 22.0.1 or newer
* **Alire (Ada Package Manager):** 2.0+
* **GNATprove / SPARK2014:** 15.1.0 (standalone bundle)

---

## 🚀 Quick Start

### 1. Clone the repository
```bash
git clone [https://github.com/ValkyrieSentinel/sokol-fsm-spark.git](https://github.com/ValkyrieSentinel/sokol-fsm-spark.git)
cd sokol-fsm-spark
Run Formal Verification (SPARK Proofs)
To execute the complete formal proof analysis, run:

Bash
gnatprove -P sokol_fsm.gpr --level=2
Expected gnatprove output:

Plaintext
Phase 1 of 3: generation of data representation information ...
Phase 2 of 3: generation of Global contracts ...
Phase 3 of 3: flow analysis and proof ...
sokol_fsm.ads:45:16: info: postcondition proved
sokol_fsm.ads:50:06: info: data dependencies proved
sokol_fsm.ads:51:16: info: postcondition proved
Build & Run Demo Executable
Build the binary via Alire and run the interactive FSM simulation:

Bash
alr build
./obj/main
📂 Project Structure
Plaintext
sokol-fsm-spark/
├── src/
│   ├── sokol_fsm.ads   # Package specification: types, abstract state, and SPARK contracts (Pre/Post)
│   ├── sokol_fsm.adb   # Package body: transitions, Refined_State, and Loop_Invariants
│   └── main.adb        # Entry point: runtime FSM demonstration
├── sokol_fsm.gpr       # GPRbuild project file
├── alire.toml          # Alire package manifest
└── README.md
📜 License
Distributed under the MIT License.
