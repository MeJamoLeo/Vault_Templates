graph LR
    %% Pattern 0: A=0, B=0
    subgraph P0[" "]
    A0["A"]:::input0 -->|0| Or0["Or"]:::gate
    B0["B"]:::input0 -->|0| Or0
    Or0 -->|0| OUT0["Out"]:::output0
    end
    
    %% Pattern 1: A=0, B=1
    subgraph P1[" "]
    A1["A"]:::input0 -->|0| Or1["Or"]:::gate
    B1["B"]:::input1 -->|1| Or1
    Or1 -->|1| OUT1["Out"]:::output1
    end
    
    %% Pattern 2: A=1, B=0
    subgraph P2[" "]
    A2["A"]:::input1 -->|1| Or2["Or"]:::gate
    B2["B"]:::input0 -->|0| Or2
    Or2 -->|1| OUT2["Out"]:::output1
    end
    
    %% Pattern 3: A=1, B=1
    subgraph P3[" "]
    A3["A"]:::input1 -->|1| Or3["Or"]:::gate
    B3["B"]:::input1 -->|1| Or3
    Or3 -->|1| OUT3["Out"]:::output1
    end

    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
    classDef input0 fill:#ff9999,stroke:#000,stroke-width:1px;
    classDef input1 fill:#99ff99,stroke:#000,stroke-width:1px;
    classDef output0 fill:#ff9999,stroke:#000,stroke-width:1px;
    classDef output1 fill:#99ff99,stroke:#000,stroke-width:1px;

    style P0 stroke-dasharray:0
    style P1 stroke-dasharray:0
    style P2 stroke-dasharray:0
    style P3 stroke-dasharray:0
    linkStyle 0,1,2,3,4,5,6,7,8,9,10,11 stroke-width:2px;
    linkStyle 0 stroke:#aa0000;
    linkStyle 1 stroke:#aa0000;
    linkStyle 2 stroke:#aa0000;
    linkStyle 3 stroke:#00aa00;
    linkStyle 4 stroke:#aa0000;
    linkStyle 5 stroke:#00aa00;
    linkStyle 6 stroke:#00aa00;
    linkStyle 7 stroke:#00aa00;
    linkStyle 8 stroke:#00aa00;
    linkStyle 9 stroke:#00aa00;
    linkStyle 10 stroke:#00aa00;
    linkStyle 11 stroke:#00aa00;
	
```mermaid
graph LR
    %% Pattern 0: A=0, B=0
    A0["A"]:::input0 -->|0| Or0["Or"]:::gate
    B0["B"]:::input0 -->|0| Or0
    Or0 -->|0| OUT0["Out"]:::output0

    %% Pattern 1: A=0, B=1
    A1["A"]:::input0 -->|0| Or1["Or"]:::gate
    B1["B"]:::input1 -->|1| Or1
    Or1 -->|1| OUT1["Out"]:::output1

    %% Pattern 2: A=1, B=0
    A2["A"]:::input1 -->|1| Or2["Or"]:::gate
    B2["B"]:::input0 -->|0| Or2
    Or2 -->|1| OUT2["Out"]:::output1

    %% Pattern 3: A=1, B=1
    A3["A"]:::input1 -->|1| Or3["Or"]:::gate
    B3["B"]:::input1 -->|1| Or3
    Or3 -->|1| OUT3["Out"]:::output1

    classDef gate fill:#d0d0d0,stroke:#000,stroke-width:2px;
    classDef input0 fill:#ff9999,stroke:#000,stroke-width:1px;
    classDef input1 fill:#99ff99,stroke:#000,stroke-width:1px;
    classDef output0 fill:#ff9999,stroke:#000,stroke-width:1px;
    classDef output1 fill:#99ff99,stroke:#000,stroke-width:1px;

    linkStyle 0 stroke:#aa0000;
    linkStyle 1 stroke:#aa0000;
    linkStyle 2 stroke:#aa0000;
    linkStyle 3 stroke:#00aa00;
    linkStyle 4 stroke:#aa0000;
    linkStyle 5 stroke:#00aa00;
    linkStyle 6 stroke:#00aa00;
    linkStyle 7 stroke:#00aa00;
    ```