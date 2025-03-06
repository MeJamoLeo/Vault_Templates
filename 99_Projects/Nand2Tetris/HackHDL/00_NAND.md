---
tags:
  - "#nand2tetris"
  - "#truth_table"
  - "#logic_circuit"
  - "#vhdl"
---

# Nand $\uparrow$
## Specification

|A|B|A NAND B|
|---|---|---|
|0|0|1|
|0|1|1|
|1|0|1|
|1|1|0|

>[!example]-
> ```mermaid
> graph LR;
> A0["A"] -->|<span style="color:#a00">0</span>| Nand0;
> B0["B"] -->|<span style="color:#a00">0</span>| Nand0;
> Nand0["Nand"]:::gate -->|<span style="color:#0a0">1</span>| OUT0["Output"];
> 
> A1["A"] -->|<span style="color:#a00">0</span>| Nand1;
> B1["B"] -->|<span style="color:#0a0">1</span>| Nand1;
> Nand1["Nand"]:::gate -->|<span style="color:#0a0">1</span>| OUT1["Output"];
> 
> A2["A"] -->|<span style="color:#0a0">1</span>| Nand2;
> B2["B"] -->|<span style="color:#a00">0</span>| Nand2;
> Nand2["Nand"]:::gate -->|<span style="color:#0a0">1</span>| OUT2["Output"];
> 
> A3["A"] -->|<span style="color:#0a0">1</span>| Nand3;
> B3["B"] -->|<span style="color:#0a0">1</span>| Nand3;
> Nand3["Nand"]:::gate -->|<span style="color:#a00">0</span>| OUT3["Output"];
> 
> classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
> ```