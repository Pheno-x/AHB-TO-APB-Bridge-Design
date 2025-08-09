# AHB to APB Bridge (Verilog HDL)

## Overview
This project implements an **AMBA AHB-to-APB bridge** in Verilog HDL, enabling communication between a high-performance AHB bus and a low-power APB bus.  
It is intended for SoC designs where peripherals connected via APB must interface with an AHB-based core or master.

---

## About AMBA
The **Advanced Microcontroller Bus Architecture (AMBA)** is an open standard from ARM used for on-chip communication in System-on-Chip (SoC) designs.  
It defines multiple bus protocols optimized for different use cases:
- **AHB (Advanced High-performance Bus)** – High-speed, pipelined system bus.
- **APB (Advanced Peripheral Bus)** – Low-power, simple peripheral bus.
- **AXI (Advanced eXtensible Interface)** – High-performance, high-bandwidth bus for complex SoCs.

---

## About AHB
The **Advanced High-performance Bus** is part of AMBA 2.0 specification and is used for high-performance, high-bandwidth communication:
- **Features**:
  - Single-clock edge protocol.
  - Pipelined operation for improved throughput.
  - Burst transfers for efficiency.
- **Typical Use**:
  - Connecting CPUs, high-speed memory, DMA controllers, and other performance-critical blocks.
- **Key Signals**:
  - `HCLK` – Clock signal.
  - `HRESETn` – Active-low reset.
  - `HADDR`, `HWDATA`, `HRDATA` – Address, write data, read data.
  - `HWRITE` – Write control signal.

---

## About APB
The **Advanced Peripheral Bus** is designed for connecting low-bandwidth, low-power peripherals:
- **Features**:
  - Simple, non-pipelined design.
  - Reduced signal count for simplicity.
  - Suitable for devices that do not require high throughput.
- **Typical Use**:
  - UART, GPIO, timers, SPI/I2C controllers.
- **Key Signals**:
  - `PCLK` – Peripheral clock.
  - `PRESETn` – Active-low reset.
  - `PADDR`, `PWDATA`, `PRDATA` – Address, write data, read data.
  - `PWRITE` – Write control signal.

---

## Features of This Project
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

## Directory Structure
'''
src/
├── ahb_apb_top.v  # Top-level integration
├── AHB_Master.v  # AHB master logic
├── ahb_slave.v  # AHB slave logic
├── apb_controller.v  # APB control logic
└── APB_Interface.v  # APB interface
'''
'''
tb/
└── AHB_APB_TOP_tb.v  # Testbench
'''
