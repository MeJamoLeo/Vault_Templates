---
tags:
  - "#nand2tetris"
  - "#logic-gates"
  - "#nand-gate"
  - "#truth-table"
  - "#boolean-algebra"
  - "#logic-design"
  - "#hardware-description-language"
  - "#hardware-implementation"
---
# Specification

|A|B|A And B|
|---|---|---|
|0|0|0|
|0|1|0|
|1|0|0|
|1|1|1|


```mermaid
graph LR;
    A0["入力 A"] -->|<span style="color:#a00">0</span>| And0;
    B0["入力 B"] -->|<span style="color:#a00">0</span>| And0;
    And0["And"]:::gate -->|<span style="color:#a00">0</span>| OUT0["出力"];

    A1["入力 A"] -->|<span style="color:#a00">0</span>| And1;
    B1["入力 B"] -->|<span style="color:#0a0">1</span>| And1;
    And1["And"]:::gate -->|<span style="color:#a00">0</span>| OUT1["出力"];

    A2["入力 A"] -->|<span style="color:#0a0">1</span>| And2;
    B2["入力 B"] -->|<span style="color:#a00">0</span>| And2;
    And2["And"]:::gate -->|<span style="color:#a00">0</span>| OUT2["出力"];

    A3["入力 A"] -->|<span style="color:#0a0">1</span>| And3;
    B3["入力 B"] -->|<span style="color:#0a0">1</span>| And3;
    And3["And"]:::gate -->|<span style="color:#0a0">1</span>| OUT3["出力"];

    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
```

---
# Imprementation

>[!tip]
> $$$
> A  \text{ And } B = \neg(A \text{ Nand } B)
> $$$


```vhdl
CHIP And {
	IN a, b;
	OUT out;
PARTS:
	Nand(a=a, b=b, out=nandOut);
	Not(in=nandOut, out=notOut);
}
```

```mermaid
graph LR;
    A["入力 A"] -->|<span style="color:#a00">0</span>| Nand0;
    B["入力 B"] -->|<span style="color:#a00">0</span>| Nand0;
    Nand0["Nand"]:::gate -->|<span style="color:#0a0">1</span>| Not0["Not"]:::gate;
    Not0 -->|<span style="color:#a00">0</span>| OUT0["出力"];

    A1["入力 A"] -->|<span style="color:#a00">0</span>| Nand1;
    B1["入力 B"] -->|<span style="color:#0a0">1</span>| Nand1;
    Nand1["Nand"]:::gate -->|<span style="color:#0a0">1</span>| Not1["Not"]:::gate;
    Not1 -->|<span style="color:#a00">0</span>| OUT1["出力"];

    A2["入力 A"] -->|<span style="color:#0a0">1</span>| Nand2;
    B2["入力 B"] -->|<span style="color:#a00">0</span>| Nand2;
    Nand2["Nand"]:::gate -->|<span style="color:#0a0">1</span>| Not2["Not"]:::gate;
    Not2 -->|<span style="color:#a00">0</span>| OUT2["出力"];

    A3["入力 A"] -->|<span style="color:#0a0">1</span>| Nand3;
    B3["入力 B"] -->|<span style="color:#0a0">1</span>| Nand3;
    Nand3["Nand"]:::gate -->|<span style="color:#a00">0</span>| Not3["Not"]:::gate;
    Not3 -->|<span style="color:#0a0">1</span>| OUT3["出力"];

    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
```