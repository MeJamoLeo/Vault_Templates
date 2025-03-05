---
tags:
  - "#logic-gates"
  - "#logic-design"
  - "#boolean-algebra"
  - "#nand-gate"
  - "#truth-table"
  - "#digital-electronics"
  - "#hardware-design"
  - "#logic-circuit"
---

# Specification

|A|B|A NAND B|
|---|---|---|
|0|0|1|
|0|1|1|
|1|0|1|
|1|1|0|

```mermaid
graph LR;
A0["A"] -->|<span style="color:#a00">0</span>| Nand0;
B0["B"] -->|<span style="color:#a00">0</span>| Nand0;
Nand0["Nand"]:::gate -->|<span style="color:#0a0">1</span>| OUT0["Output"];

A1["A"] -->|<span style="color:#a00">0</span>| Nand1;
B1["B"] -->|<span style="color:#0a0">1</span>| Nand1;
Nand1["Nand"]:::gate -->|<span style="color:#0a0">1</span>| OUT1["Output"];

A2["A"] -->|<span style="color:#0a0">1</span>| Nand2;
B2["B"] -->|<span style="color:#a00">0</span>| Nand2;
Nand2["Nand"]:::gate -->|<span style="color:#0a0">1</span>| OUT2["Output"];

A3["A"] -->|<span style="color:#0a0">1</span>| Nand3;
B3["B"] -->|<span style="color:#0a0">1</span>| Nand3;
Nand3["Nand"]:::gate -->|<span style="color:#a00">0</span>| OUT3["Output"];

classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
```

```mermaid
graph LR;
    A["A"] --> Nand0;
    B["B"] --> Nand0;
    Nand0["Nand"]:::gate --> n1["n1"];
    
    A["A"] --> Nand1;
    n1 --> Nand1;
    Nand1["Nand"]:::gate --> n2["n2"];
    
    B["B"] --> Nand2;
    n1 --> Nand2;
    Nand2["Nand"]:::gate --> n3["n3"];
    
    n2 --> Nand3;
    n3 --> Nand3;
    Nand3["Nand"]:::gate --> OUT["Output"];
    
    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;

```