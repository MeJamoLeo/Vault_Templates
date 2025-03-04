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
## Logical Expressions

$ A \land B $

## Logical Expressions



```hdl
CHIP And {
	IN a, b;
	OUT out;
PARTS:
	Nand(a=a, b=b, out=nandOut);
	Not(in=nand
}
```