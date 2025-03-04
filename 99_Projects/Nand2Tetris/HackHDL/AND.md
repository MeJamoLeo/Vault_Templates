---
tags:
  - "#nand2tetris"
  - "#logic-gates"
  - "#nand-gate"
  - "#truth-table"
  - "#boolean-algebra"
  - "#logic-design"
---
# Specification

|A|B|A AND B|
|---|---|---|
|0|0|0|
|0|1|0|
|1|0|0|
|1|1|1|


```mermaid
graph LR;
    A0["入力 A"] -->|<span style="color:#a00">0</span>| AND0;
    B0["入力 B"] -->|<span style="color:#a00">0</span>| AND0;
    AND0["ANDゲート"]:::gate -->|<span style="color:#a00">0</span>| OUT0["出力"];

    A1["入力 A"] -->|<span style="color:#a00">0</span>| AND1;
    B1["入力 B"] -->|<span style="color:#0a0">1</span>| AND1;
    AND1["ANDゲート"]:::gate -->|<span style="color:#a00">0</span>| OUT1["出力"];

    A2["入力 A"] -->|<span style="color:#0a0">1</span>| AND2;
    B2["入力 B"] -->|<span style="color:#a00">0</span>| AND2;
    AND2["ANDゲート"]:::gate -->|<span style="color:#a00">0</span>| OUT2["出力"];

    A3["入力 A"] -->|<span style="color:#0a0">1</span>| AND3;
    B3["入力 B"] -->|<span style="color:#0a0">1</span>| AND3;
    AND3["ANDゲート"]:::gate -->|<span style="color:#0a0">1</span>| OUT3["出力"];

    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
```

---
# Imprementation

A _AND_ B = ~(A _NAND_ B)

```hdl
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
    A["入力 A"] -->|<span style="color:#a00">0</span>| NAND0;
    B["入力 B"] -->|<span style="color:#a00">0</span>| NAND0;
    NAND0["NANDゲート"]:::gate -->|<span style="color:#0a0">1</span>| NOT0["NOTゲート"]:::gate;
    NOT0 -->|<span style="color:#a00">0</span>| OUT0["出力"];

    A1["入力 A"] -->|<span style="color:#a00">0</span>| NAND1;
    B1["入力 B"] -->|<span style="color:#0a0">1</span>| NAND1;
    NAND1["NANDゲート"]:::gate -->|<span style="color:#0a0">1</span>| NOT1["NOTゲート"]:::gate;
    NOT1 -->|<span style="color:#a00">0</span>| OUT1["出力"];

    A2["入力 A"] -->|<span style="color:#0a0">1</span>| NAND2;
    B2["入力 B"] -->|<span style="color:#a00">0</span>| NAND2;
    NAND2["NANDゲート"]:::gate -->|<span style="color:#0a0">1</span>| NOT2["NOTゲート"]:::gate;
    NOT2 -->|<span style="color:#a00">0</span>| OUT2["出力"];

    A3["入力 A"] -->|<span style="color:#0a0">1</span>| NAND3;
    B3["入力 B"] -->|<span style="color:#0a0">1</span>| NAND3;
    NAND3["NANDゲート"]:::gate -->|<span style="color:#a00">0</span>| NOT3["NOTゲート"]:::gate;
    NOT3 -->|<span style="color:#0a0">1</span>| OUT3["出力"];

    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
```