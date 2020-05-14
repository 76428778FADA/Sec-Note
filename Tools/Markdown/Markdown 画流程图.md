#### 如何在 markdown 中使用 mermaid

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473229763.png)

流程图方向有下面几个值

*   TB 从上到下
*   BT 从下到上
*   RL 从右到左
*   LR 从左到右
*   TD 同 TB

##### 示例

从上到下

效果：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473229765.png)

从左到右

效果：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473229813.png)

#### 基本图形

*   id + [文字描述] 矩形
*   id + (文字描述) 圆角矩形
*   id + > 文字描述] 不对称的矩形
*   id + {文字描述} 菱形
*   id + ((文字描述)) 圆形

##### 示例

```
mermaid
graph TD
    id[带文本的矩形]
    id4(带文本的圆角矩形)
    id3>带文本的不对称的矩形]
    id1{带文本的菱形}
    id2((带文本的圆形))
```

效果：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473229814.png)

#### 节点之间的连接

*   A --> B A 带箭头指向 B
*   A --- B A 不带箭头指向 B
*   A -.- B A 用虚线指向 B
*   A -.-> B A 用带箭头的虚线指向 B
*   A ==> B A 用加粗的箭头指向 B
*   A -- 描述 --- B A 不带箭头指向 B 并在中间加上文字描述
*   A -- 描述 --> B A 带箭头指向 B 并在中间加上文字描述
*   A -. 描述 .-> B A 用带箭头的虚线指向 B 并在中间加上文字描述
*   A == 描述 ==> B A 用加粗的箭头指向 B 并在中间加上文字描述

##### 示例

```
mermaid
graph LR
    A[A] --> B[B] 
    A1[A] --- B1[B] 
    A4[A] -.- B4[B] 
    A5[A] -.-> B5[B] 
    A7[A] ==> B7[B] 
    A2[A] -- 描述 --- B2[B] 
    A3[A] -- 描述 --> B3[B] 
    A6[A] -. 描述 .-> B6[B] 
    A8[A] == 描述 ==> B8[B]
```

效果：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473229816.png)

#### 子流程图

格式

```
subgraph title
    graph definition
end
```

##### 示例

```
mermaid
graph TB
    c1-->a2
    subgraph one
    a1-->a2
    end
    subgraph two
    b1-->b2
    end
    subgraph three
    c1-->c2
    end
```

效果：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473229817.png)

#### 自定义样式

语法：style id 具体样式

##### 示例

```
mermaid
graph LR
    id1(Start)-->id2(Stop)
    style id1 fill:#f9f,stroke:#333,stroke-width:4px,fill-opacity:0.5
    style id2 fill:#ccf,stroke:#f66,stroke-width:2px,stroke-dasharray: 10,5
```

效果：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473229818.png)

#### demo

绘制一个流程图, 找出 A、 B、 C 三个数中最大的一个数。

##### 写法

```
mermaid
graph LR
    start[开始] --> input[输入A,B,C]
    input --> conditionA{A是否大于B}
    conditionA -- YES --> conditionC{A是否大于C}
    conditionA -- NO --> conditionB{B是否大于C}
    conditionC -- YES --> printA[输出A]
    conditionC -- NO --> printC[输出C]
    conditionB -- YES --> printB[输出B]
    conditionB -- NO --> printC[输出C]
    printA --> stop[结束]
    printC --> stop
    printB --> stop
```

效果：

![](https://cdn.jsdelivr.net/gh/qoo3/imgur@master/bookmaker/1589473229831.png)
