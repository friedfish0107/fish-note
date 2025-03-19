# Mermaid插件 #markdown #语法

Markdown 的 **Mermaid 插件** 是一种将文本代码转换为可视化图表的工具，它允许你在 Markdown 中直接编写图表定义，并实时渲染成图形。以下是其核心作用、支持的功能及实际应用场景的详细说明：

---

## 一、核心作用

1. 文本化图表  
   通过简单的代码语法（非图形界面）直接生成图表，无需依赖外部绘图工具（如 Visio、Draw.io）。

1. 版本控制友好  
   图表以纯文本形式存储，方便通过 Git 等工具进行版本管理和协作修改。

1. 无缝集成 Markdown  
   在 Markdown 文件中嵌入图表代码，渲染后与文档内容高度融合，提升可读性。

1. 实时预览  
   在 VS Code 等支持 Mermaid 的编辑器中，可实时查看图表效果，无需手动导出图片。

---

## 二、支持的图表类型与示例

Mermaid 支持多种常见图表类型，以下是主要类别及语法示例：

1. 流程图（Flowchart）
用于描述流程或步骤逻辑。

```mermaid
graph TD
    A[开始] --> B{条件判断}
    B -->|是| C[执行操作]
    B -->|否| D[结束]
    C --> D
```

1. 序列图（Sequence Diagram）
展示对象之间的交互顺序。

```mermaid
sequenceDiagram
    Alice->>Bob: 你好，需要帮助吗？
    Bob-->>Alice: 是的，请检查文档
    Alice->>Bob: 已更新，请查看
```

1. 甘特图（Gantt Chart）
用于项目管理中的时间规划。

```mermaid
gantt
    title 项目计划
    dateFormat YYYY-MM-DD
    section 阶段A
    任务1 :a1, 2023-10-01, 7d
    任务2 :after a1, 5d
    section 阶段B
    任务3 :2023-10-10, 3d
```

1. 类图（Class Diagram）
描述类与类之间的关系（面向对象设计）。

```mermaid
classDiagram
    class Animal {
        +String name
        +void eat()
    }
    class Dog {
        +void bark()
    }
    Animal <|-- Dog
```

1. 状态图（State Diagram）
展示状态之间的转换逻辑。

```mermaid
stateDiagram-v2
    [*] --> 待机
    待机 --> 运行中 : 启动
    运行中 --> 待机 : 停止
    运行中 --> 报错 : 异常
    报错 --> 待机 : 重启
```

1. 饼图（Pie Chart）
展示数据比例分布。

```mermaid
pie title 市场份额
    "苹果" : 45
    "三星" : 30
    "华为" : 15
    "其他" : 10
```

1. 用户旅程图（User Journey）
描述用户与系统的交互流程。

```mermaid
journey
    title 用户登录流程
    section 登录
      用户打开页面: 5: 用户
      输入账号密码: 3: 用户
      提交验证: 5: 系统
    section 结果
      成功: 4: 系统
      失败: 2: 系统
```
