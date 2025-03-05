# Specification

|A|B|A XOR B|
|---|---|---|
|0|0|0|
|0|1|1|
|1|0|1|
|1|1|0|

```mermaid
graph LR;
    A0["入力 A"] -->|<span style="color:#a00">0</span>| Xor0;
    B0["入力 B"] -->|<span style="color:#a00">0</span>| Xor0;
    Xor0["Xor"]:::gate -->|<span style="color:#a00">0</span>| OUT0["出力"];

    A1["入力 A"] -->|<span style="color:#a00">0</span>| Xor1;
    B1["入力 B"] -->|<span style="color:#0a0">1</span>| Xor1;
    Xor1["Xor"]:::gate -->|<span style="color:#0a0">1</span>| OUT1["出力"];

    A2["入力 A"] -->|<span style="color:#0a0">1</span>| Xor2;
    B2["入力 B"] -->|<span style="color:#a00">0</span>| Xor2;
    Xor2["Xor"]:::gate -->|<span style="color:#0a0">1</span>| OUT2["出力"];

    A3["入力 A"] -->|<span style="color:#0a0">1</span>| Xor3;
    B3["入力 B"] -->|<span style="color:#0a0">1</span>| Xor3;
    Xor3["Xor"]:::gate -->|<span style="color:#a00">0</span>| OUT3["出力"];

    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
```

---

# Implementation

> [!tip]
> 

$$
A \text{ XOR } B = (A \land \lnot B) \lor (\lnot A \land B)
$$


（VHDL の実装はご自身で検討してください。）

---

