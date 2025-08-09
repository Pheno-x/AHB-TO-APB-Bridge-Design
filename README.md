# AHB-TO-APB-Bridge-Design
AMBA AHB-to-APB bridge module implemented in Verilog HDL for SoC bus interfacing.

# AHB to APB Bridge (Verilog HDL)

## Overview
This project implements an **AMBA AHB-to-APB bridge** in Verilog HDL, enabling communication between a high-performance AHB bus and a low-power APB bus.  
It is intended for SoC designs where peripherals connected via APB must interface with an AHB-based core or master.

---

## Features
- Implements standard **AMBA AHB** and **AMBA APB** protocols.
- Modular design split into:
  - **AHB Master** (`AHB_Master.v`)
  - **AHB Slave** (`ahb_slave.v`)
  - **APB Controller** (`apb_controller.v`)
  - **APB Interface** (`APB_Interface.v`)
  - **Top-Level Module** (`ahb_apb_top.v`)
- Synthesizable for FPGA or ASIC workflows.
- Includes a Verilog testbench (`AHB_APB_TOP_tb.v`).

---

## Block Diagram
![AHB to APB Block Diagram](docs/block_diagram.png)
*(Replace with your actual diagram file)*

---

## Directory Structure
