# implements #java #语法

>最后更新：2025-03-10 19:32

在 Java 中，`implements` 是一个关键字，**用于类实现接口（Interface）**。它的作用是让一个类遵循某个或多个接口的规范，并强制要求该类提供接口中定义的所有抽象方法的具体实现。

---

## 核心概念

- 接口（`Interface`）：定义了一组抽象方法（没有方法体）的契约。接口也可以包含默认方法（`default` 方法）、静态方法（`static` 方法）和常量。

- 实现接口：当类使用 `implements` 时，它必须为接口中所有的抽象方法提供具体实现（除非这个类本身是抽象类）。

---

## 语法示例

```java
// 定义一个接口
interface Animal {
    void eat();   // 抽象方法（默认 public abstract）
    void sleep();
}

// 类通过 implements 实现接口
class Dog implements Animal {
    @Override
    public void eat() {
        System.out.println("Dog eats bones");
    }

    @Override
    public void sleep() {
        System.out.println("Dog sleeps on the couch");
    }
}
```

## 关键点

1. 多接口实现
一个类可以同时实现多个接口（Java 不支持多继承，但支持多接口实现）：

```java
class Bird implements Flyable, Singable {
    // 实现 Flyable 和 Singable 接口的所有方法
}
```

1. 必须实现所有抽象方法
如果接口有抽象方法，实现类必须全部覆盖这些方法，否则该类必须声明为 `abstract`（抽象类）。

1. 接口的默认方法（Java 8+）
接口可以有默认方法（`default` 方法），实现类可以直接继承或重写它：

```java
interface Vehicle {
    default void start() {
        System.out.println("Vehicle starts");
    }
}
```

1. 接口的多态性
通过接口类型引用对象，实现多态：

```java
Animal myDog = new Dog();
myDog.eat(); // 调用 Dog 类的 eat() 方法
```

---

## `implements` vs `extends`

|关键字| 用途 |数量限制| 类型|
|---|---|---|---|
|`extends`| 继承类（单继承）| 只能继承一个父类 |类到类|
|`implements` |实现接口（多实现）| 可同时实现多个接口 |类到接口|

---

示例：一个类可以同时继承一个父类并实现多个接口：

```java
class Dog extends Mammal implements Animal, Pet {
    // 继承 Mammal，同时实现 Animal 和 Pet 接口
}
```

## 总结

- `implements` 用于类遵循接口的规范，实现多态和代码解耦。

- 接口定义“能做什么”，类通过 `implements` 定义“具体怎么做”。

- 通过接口可以实现灵活的设计模式（如策略模式、适配器模式等）。
