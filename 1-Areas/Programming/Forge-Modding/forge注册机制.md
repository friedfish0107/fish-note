# forge注册机制 #forge #mod #注册

>最后更新：2025-03-09 23:35

在 Minecraft Forge 中，物品和方块的注册是通过 [DeferredRegister][def] 机制实现的，这是一种基于事件驱动的延迟注册方式。以下是其详细执行流程：

---

## 注册的核心流程

1. **创建 `DeferredRegister`**
   * 在 Mod 主类中，通过 `DeferredRegister.create()` 创建一个注册容器，关联到对应的注册表（如 `ITEMS` 或 `BLOCKS`）和你的 Mod ID。
   * 示例

   ```java
   public static final DeferredRegister<Item> ITEMS = DeferredRegister.create(ForgeRegistries.ITEMS, "MODID");

   public static final DeferredRegister<Block> BLOCKS = DeferredRegister.create(ForgeRegistries.BLOCKS, "MODID");
   ```

2. **定义注册项**
   * 使用 register 方法为每个物品或方块生成一个 RegistryObject。
   * 示例：

   ```java
   public static final RegistryObject<Item> EXAMPLE_ITEM = ITEMS.register("example_item", () -> new Item(...));
   public static final RegistryObject<Block> EXAMPLE_BLOCK = BLOCKS.register("example_block", () -> new Block(...));
   ```

3. **将注册容器绑定到[事件总线](事件总线)**
   * 在 Mod 主类的构造函数中，将 DeferredRegister 实例（如 ITEMS 和 BLOCKS）添加到 Forge 的事件总线。

   * **关键代码**：

   ```java
   public YourModClass() {
    ITEMS.register(FMLJavaModLoadingContext.get().getModEventBus());
    BLOCKS.register(FMLJavaModLoadingContext.get().getModEventBus());
    // 其他初始化代码...
   }
   ```

---

## 底层执行原理

1. 延迟注册：

   * DeferredRegister 不会立即将物品或方块注册到游戏中，而是将注册任务保存起来。

   * 当 Forge 触发 `RegistryEvent.Register<T>` 事件时（例如 `Register<Item>` 或 `Register<Block>`），才会实际执行注册。

2. 事件触发时机：

   * Forge 在 Mod 加载阶段会自动触发注册事件。

   * 你的 DeferredRegister 会在此时将定义的所有 RegistryObject 提交给游戏注册表。

3. RegistryObject 的作用：

   * 它是一个“占位符”，保存对未来注册对象的引用。

   * 可以通过 RegistryObject.get() 安全地获取注册后的对象（例如 EXAMPLE_ITEM.get()）。

---

## 代码执行顺序示例

   假设 Mod 主类名为 `ExampleMod`，流程如下：

   ```java
   @Mod("examplemod")
   public class ExampleMod {
      public static final String MODID = "examplemod";
      public static final DeferredRegister<Item> ITEMS = DeferredRegister.create(ForgeRegistries.ITEMS, MODID);
      public static final RegistryObject<Item> EXAMPLE_ITEM = ITEMS.register("example_item", () -> new Item(...));

      public ExampleMod() {
        ITEMS.register(FMLJavaModLoadingContext.get().getModEventBus()); // 绑定到事件总线
      }
   }
   ```

1. 游戏启动时，Forge 加载 Mod。

2. 在初始化阶段，Forge 触发 `RegistryEvent.Register<Item>` 事件。

3. DeferredRegister 监听到事件，自动执行注册。

4. 游戏内部注册表中会新增一个名为 `examplemod:example_item` 的物品。

>未完成部分  
>如果需要更深入理解，可以研究 Forge 的 RegistryEvent 和 IForgeRegistry 相关源码（例如 net.minecraftforge.registries 包）。这是 Forge 注册机制的核心部分！

[def]: /3-Resources/Docs/forge/deferredregister.md
