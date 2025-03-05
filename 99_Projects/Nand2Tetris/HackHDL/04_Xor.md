---
tags:
  - "#logic-gates"
  - "#logic-design"
  - "#boolean-algebra"
  - "#xor-gate"
  - "#vhdl"
  - "#hardware-design"
---
# Specification

|A|B|A XOR B|
|---|---|---|
|0|0|0|
|0|1|1|
|1|0|1|
|1|1|0|

```mermaid
graph LR;
    A0["A"] -->|<span style="color:#a00">0</span>| Xor0;
    B0["B"] -->|<span style="color:#a00">0</span>| Xor0;
    Xor0["Xor"]:::gate -->|<span style="color:#a00">0</span>| OUT0["Output"];

    A1["A"] -->|<span style="color:#a00">0</span>| Xor1;
    B1["B"] -->|<span style="color:#0a0">1</span>| Xor1;
    Xor1["Xor"]:::gate -->|<span style="color:#0a0">1</span>| OUT1["Output"];

    A2["A"] -->|<span style="color:#0a0">1</span>| Xor2;
    B2["B"] -->|<span style="color:#a00">0</span>| Xor2;
    Xor2["Xor"]:::gate -->|<span style="color:#0a0">1</span>| OUT2["Output"];

    A3["A"] -->|<span style="color:#0a0">1</span>| Xor3;
    B3["B"] -->|<span style="color:#0a0">1</span>| Xor3;
    Xor3["Xor"]:::gate -->|<span style="color:#a00">0</span>| OUT3["Output"];

    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
```

---

# Implementation

> [!tip]
> 
> $$
> (\lnot A \land B) 
> \lor 
> (A \land \lnot B) 
> = A \text{ XOR } B
> $$


```vhdl
CHIP Xor {
    IN a, b;
    OUT out;

    PARTS:
    Not(in=a, out=notA);
    Not(in=b, out=notB);

    And(a=a,   b=notB, out=aAndNotB);
    And(a=notA, b=b,   out=notAAndB);

    Or(a=aAndNotB, b=notAAndB, out=out);
}
```

```mermaid
graph LR;
    A["a"] --> NotA["Not: notA"];
    B["b"] --> NotB["Not: notB"];

    A --> And1["And: a AND notB"];
    NotB --> And1;

    NotA --> And2["And: notA AND b"];
    B --> And2;

    And1 --> OrGate["Or: (a AND notB) OR (notA AND b)"];
    And2 --> OrGate;

    OrGate --> Out["Output out"];

    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
    class NotA,NotB,And1,And2,OrGate gate;

```

```mermaid
graph TD;
    %% Case 1: A=0, B=0 → XOR = 0
    subgraph Case1_A0B0
      A0["A = 0"]
      B0["B = 0"]
      NotA0["Not(a) = 1"]
      NotB0["Not(b) = 1"]
      And0["And: a AND notB = 0"]
      And0b["And: notA AND b = 0"]
      Or0["Or: (a AND notB) OR (notA AND b) = 0"]
      
      A0 -->|<font color="#a00">0</font>| NotA0;
      B0 -->|<font color="#a00">0</font>| NotB0;
      
      A0 -->|<font color="#a00">0</font>| And0;
      NotB0 -->|<font color="#0a0">1</font>| And0;
      
      NotA0 -->|<font color="#0a0">1</font>| And0b;
      B0 -->|<font color="#a00">0</font>| And0b;
      
      And0 -->|<font color="#a00">0</font>| Or0;
      And0b -->|<font color="#a00">0</font>| Or0;
    end

    %% Case 2: A=0, B=1 → XOR = 1
    subgraph Case2_A0B1
      A1["A = 0"]
      B1["B = 1"]
      NotA1["Not(a) = 1"]
      NotB1["Not(b) = 0"]
      And1["And: a AND notB = 0"]
      And1b["And: notA AND b = 1"]
      Or1["Or: (a AND notB) OR (notA AND b) = 1"]
      
      A1 -->|<font color="#a00">0</font>| NotA1;
      B1 -->|<font color="#0a0">1</font>| NotB1;
      
      A1 -->|<font color="#a00">0</font>| And1;
      NotB1 -->|<font color="#a00">0</font>| And1;
      
      NotA1 -->|<font color="#0a0">1</font>| And1b;
      B1 -->|<font color="#0a0">1</font>| And1b;
      
      And1 -->|<font color="#a00">0</font>| Or1;
      And1b -->|<font color="#0a0">1</font>| Or1;
    end

    %% Case 3: A=1, B=0 → XOR = 1
    subgraph Case3_A1B0
      A2["A = 1"]
      B2["B = 0"]
      NotA2["Not(a) = 0"]
      NotB2["Not(b) = 1"]
      And2["And: a AND notB = 1"]
      And2b["And: notA AND b = 0"]
      Or2["Or: (a AND notB) OR (notA AND b) = 1"]
      
      A2 -->|<font color="#0a0">1</font>| NotA2;
      B2 -->|<font color="#a00">0</font>| NotB2;
      
      A2 -->|<font color="#0a0">1</font>| And2;
      NotB2 -->|<font color="#0a0">1</font>| And2;
      
      NotA2 -->|<font color="#a00">0</font>| And2b;
      B2 -->|<font color="#a00">0</font>| And2b;
      
      And2 -->|<font color="#0a0">1</font>| Or2;
      And2b -->|<font color="#a00">0</font>| Or2;
    end

    %% Case 4: A=1, B=1 → XOR = 0
    subgraph Case4_A1B1
      A3["A = 1"]
      B3["B = 1"]
      NotA3["Not(a) = 0"]
      NotB3["Not(b) = 0"]
      And3["And: a AND notB = 0"]
      And3b["And: notA AND b = 0"]
      Or3["Or: (a AND notB) OR (notA AND b) = 0"]
      
      A3 -->|<font color="#0a0">1</font>| NotA3;
      B3 -->|<font color="#0a0">1</font>| NotB3;
      
      A3 -->|<font color="#0a0">1</font>| And3;
      NotB3 -->|<font color="#a00">0</font>| And3;
      
      NotA3 -->|<font color="#a00">0</font>| And3b;
      B3 -->|<font color="#0a0">1</font>| And3b;
      
      And3 -->|<font color="#a00">0</font>| Or3;
      And3b -->|<font color="#a00">0</font>| Or3;
    end
```
