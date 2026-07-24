# 🚀 SystemVerilog & UVM Verification Portfolio

Welcome to my Hardware Verification repository! This repository serves as a showcase of my journey learning, building, and scaling Design Verification (DV) environments using **SystemVerilog** and **Universal Verification Methodology (UVM)**.



## 🏗️ Architecture Blueprint

Each UVM project in this repository follows standard industry architecture guidelines:

```text
               +---------------------------------------------------+
               |                     UVM Test                      |
               |  +---------------------------------------------+  |
               |  |                   UVM Env                   |  |
               |  |  +---------------------+  +--------------+  |  |
               |  |  |      UVM Agent      |  |     UVM      |  |  |
               |  |  | +-----------------+ |  |  Scoreboard  |  |  |
               |  |  | |   UVM Sequencer | |  +-------^------+  |  |
               |  |  | +--------+--------+ |          |         |  |
 UVM Sequence -+--+->|          |          |          |         |  |
               |  |  | +--------v--------+ |          |         |  |
               |  |  | |    UVM Driver   | |          |         |  |
               |  |  | +--------+--------+ |          |         |  |
               |  |  |          |          |          |         |  |
               |  |  | +--------v--------+ |          |         |  |
               |  |  | |   UVM Monitor   |-+----------+         |  |
               |  |  | +--------+--------+ | (Analysis Port)    |  |
               |  |  +----------|----------+                    |  |
               |  +-------------|-------------------------------+  |
               +----------------|----------------------------------+
                                | (Virtual Interface)
                                v
                   +------------------------+
                   |  Design Under Test     |
                   |        (DUT)           |
                   +------------------------+
```

## 🛠️ Tools & Simulators
The testbenches in this repository are developed and validated using:
* **Simulators:** Synopsys VCS / Siemens QuestaSim / Aldec Riviera-Pro
* **UVM Version:** UVM 1.2
* **Online Sandbox:** EDA Playground

## 🎯 Key Verification Concepts Implemented
* **UVM Factory Registration & Overrides:** `uvm_component_utils`, `uvm_object_utils`
* **Configuration Database:** Safe handle passing using `uvm_config_db`
* **TLM Communication:** `uvm_analysis_port` and `uvm_analysis_imp` connections
* **Synchronous Driving & Sampling:** Avoiding race conditions using `@(posedge clk)` and delta delays
* **Self-Checking Scoreboards:** Dynamic golden reference models comparing expected vs. actual DUT outputs
