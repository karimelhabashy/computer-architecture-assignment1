# Computer Architecture — Assignment 1

A two-part assignment covering digital circuit design in Verilog and a companion C++ submission encoder.

## Part 1 — Verilog Hardware Module (`assign1_arch.v`)

A Verilog description of a digital logic circuit designed as part of the computer architecture course.

**How it works:**
- Describes hardware behavior using Verilog HDL (Hardware Description Language)
- Can be simulated using tools like Icarus Verilog or ModelSim
- Models combinational/sequential logic at the gate/register level

**Simulate:**
```bash
iverilog -o sim assign1_arch.v
vvp sim
```

## Part 2 — Assignment Encoder (`assign_encoder.cpp`)

The same submission encoder used across Advanced Data Structures assignments — encodes a text file into a binary format tagged with the assignment ID and student IDs.

```bash
g++ assign_encoder.cpp -o encoder
./encoder myfile.txt 1 1 20210001
```
