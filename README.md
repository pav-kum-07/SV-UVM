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
