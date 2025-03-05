---
tags:
  - "#logic-gates"
  - "#nand2tetris"
  - "#nand-gate"
  - "#hardware-description-language"
  - "#logic-design"
  - "#truth-table"
  - "#boolean-algebra"
  - "#hardware-implementation"
---
# Specification

|A|NOT A|
|---|---|
|0|1|
|1|0|

``` mermaid
graph LR;
    A0["入力 A"] -->|<span style="color:#a00">0</span>| NAND0;
    NAND0["NOT"]:::gate -->|<span style="color:#0a0">1</span>| OUT0["出力"];

    A1["入力 A"] -->|<span style="color:#0a0">1</span>| NAND1;
    NAND1["NOT"]:::gate -->|<span style="color:#a00">0</span>| OUT1["出力"];

    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
```

---

# Imprementation

~A = A NAND A

```hdl
CHIP Not {
    IN in;
    OUT out;
    
    PARTS:
    Nand(a=in, b=in, out=out);
}
```

```mermaid
graph LR;
    A["入力 A"] -->|<span style="color:#a00">0</span>| NAND0;
    NAND0["NAND"]:::gate -->|<span style="color:#0a0">1</span>| OUT0["出力"];

    A1["入力 A"] -->|<span style="color:#0a0">1</span>| NAND1;
    NAND1["NAND"]:::gate -->|<span style="color:#a00">0</span>| OUT1["出力"];

    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
```

