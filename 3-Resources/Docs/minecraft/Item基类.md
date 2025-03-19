# ITEM #minecraft #实现原理

>最后更新：2025-03-09 23:51

来源：`net.minecraft.world.item`

注：forge修改了mc的代码，关于其他更改部分见[更改的原版内容](/1-Areas/Programming/Forge-Modding/更改的原版内容.md)

## 逐段解析

### 一，继承接口并初始化属性

```java
public class Item
implements FeatureElement,
ItemLike {
    private static final Logger LOGGER = LogUtils.getLogger();
    public static final Map<Block, Item> BY_BLOCK = Maps.newHashMap();
    protected static final UUID BASE_ATTACK_DAMAGE_UUID = UUID.fromString("CB3F55D3-645C-4F38-A497-9C13A33DB5CF");
    protected static final UUID BASE_ATTACK_SPEED_UUID = UUID.fromString("FA233E1C-4180-4865-B01B-BCCE9785ACA3");
    public static final int MAX_STACK_SIZE = 64;
    public static final int EAT_DURATION = 32;
    public static final int MAX_BAR_WIDTH = 13;
    private final Holder.Reference<Item> builtInRegistryHolder = BuiltInRegistries.ITEM.createIntrusiveHolder(this);
    private final Rarity rarity;
    private final int maxStackSize;
    private final int maxDamage;
    private final boolean isFireResistant;
    @Nullable
    private final Item craftingRemainingItem;
    @Nullable
    private String descriptionId;
    @Nullable
    private final FoodProperties foodProperties;
    private final FeatureFlagSet requiredFeatures;
```

1. ### [继承接口](../../../1-Areas/Programming/java/implements.md)

   ```java
   public class Item
   implements FeatureElement,
   ItemLike {
   ```

   - **作用**：继承`FeatureElement`,`ItemLike`

2. ### 日志记录器

   ```java
   private static final Logger LOGGER = LogUtils.getLogger();
   ```

   - **作用**：用于记录物品相关日志
   - **技术细节**：`LogUtils.getLogger()`是minecraft封装的日志工具，见[LogUtils](LogUtils.md)
  
3. ### 方块与物品的映射表

   ```java
   public static final Map<Block, Item> BY_BLOCK = Maps.newHashMap();
   ```

   - **作用**：存储方块（Block）与其对应物品（Item）的关联关系。例如，破坏石头方块会掉落石头物品。

   - **技术细节**：Maps.newHashMap()来自Google Guava库，创建一个空的HashMap。

4. ### 攻击属性修饰符的`UUID`

   ```java
   protected static final UUID BASE_ATTACK_DAMAGE_UUID = UUID.fromString("CB3F55D3-645C-4F38-A497-9C13A33DB5CF");
    protected static final UUID BASE_ATTACK_SPEED_UUID = UUID.fromString("FA233E1C-4180-4865-B01B-BCCE9785ACA3");
   ```

   - **作用**：唯一标识武器的基础攻击伤害和攻击速度属性修饰符。例如，剑类物品会通过这两个[UUID](UUID.md)添加默认属性。
   - **例子**：钻石剑的`+7攻击伤害`和`1.6攻击速度`即通过此UUID绑定。

5. ### 物品堆叠与交互常量

   ```java
   public static final int MAX_STACK_SIZE = 64;      // 最大堆叠数（默认64）
   public static final int EAT_DURATION = 32;        // 进食耗时（32 ticks = 1.6秒）
   public static final int MAX_BAR_WIDTH = 13;       // 耐久条最大宽度（像素）
   ```

   - **作用**：
     - `MAX_STACK_SIZE`：控制物品的堆叠上限（如雪球可堆叠16，工具为1）。

     - `EAT_DURATION`：进食动作的默认持续时间（快速食物如曲奇为16 ticks）。

     - `MAX_BAR_WIDTH`：用于绘制耐久条或类似UI元素的宽度（如工具的耐久条）。

6. ### 注册表持有者

   ```java
   private final Holder.Reference<Item> builtInRegistryHolder = BuiltInRegistries.ITEM.createIntrusiveHolder(this);
   ```

   - **作用**：将当前物品注册到游戏的全局物品注册表（`BuiltInRegistries.ITEM`）中，以便通过ID或名称检索。
   - **技术细节**：`createIntrusiveHolder`是Minecraft内部方法，用于创建与注册表强关联的持有者对象。

7. ### 物品核心属性

   ```java
   private final Rarity rarity;               // 稀有度（影响名称颜色）
   private final int maxStackSize;            // 当前物品的堆叠上限
   private final int maxDamage;               // 最大耐久值（>0表示可损耗）
   private final boolean isFireResistant;     // 是否防火
   @Nullable private final Item craftingRemainingItem; // 合成后的剩余物品（如空桶）
   @Nullable private final FoodProperties foodProperties; // 食物属性（饱食度、效果等）
   ```

   - **示例**：
     - `rarity = Rarity.EPIC`：下界之星的名称为紫色。
     - `maxDamage = 1561`：钻石镐的耐久值为1561。
     - `craftingRemainingItem = Items.GLASS_BOTTLE`：水瓶合成后返回玻璃瓶。
   - **链接**：稀有度,食物属性

8. ### 本地化与特性标志

   ```java
   @Nullable private String descriptionId;    // 本地化键（如"item.minecraft.diamond"）
   private final FeatureFlagSet requiredFeatures; // 依赖的游戏特性集合
   ```

   - **作用**：
      - `descriptionId`：延迟初始化的本地化键，用于获取翻译后的物品名称。

      - `requiredFeatures`：控制物品是否在特定游戏版本或实验性内容中启用（如1.20的新物品）。

### 二，定义方法

>要注意的是，此处有一部分方法是别人调用我们，而不是我们调用其中内容，可以通过继承基类更改返回值

```java


    

    @Deprecated
    public static Item byBlock(Block block) {
        return BY_BLOCK.getOrDefault(block, Items.AIR);
    }

    @Deprecated
    public Holder.Reference<Item> builtInRegistryHolder() {
        return this.builtInRegistryHolder;
    }

    public void onUseTick(Level level, LivingEntity livingEntity, ItemStack itemStack, int n) {
    }

    public void onDestroyed(ItemEntity itemEntity) {
    }

    public void verifyTagAfterLoad(CompoundTag compoundTag) {
    }

    public boolean canAttackBlock(BlockState blockState, Level level, BlockPos blockPos, Player player) {
        return true;
    }

    @Override
    public Item asItem() {
        return this;
    }

    public InteractionResult useOn(UseOnContext useOnContext) {
        return InteractionResult.PASS;
    }

    public float getDestroySpeed(ItemStack itemStack, BlockState blockState) {
        return 1.0f;
    }

    public InteractionResultHolder<ItemStack> use(Level level, Player player, InteractionHand interactionHand) {
        if (this.isEdible()) {
            ItemStack itemStack = player.getItemInHand(interactionHand);
            if (player.canEat(this.getFoodProperties().canAlwaysEat())) {
                player.startUsingItem(interactionHand);
                return InteractionResultHolder.consume(itemStack);
            }
            return InteractionResultHolder.fail(itemStack);
        }
        return InteractionResultHolder.pass(player.getItemInHand(interactionHand));
    }

    public ItemStack finishUsingItem(ItemStack itemStack, Level level, LivingEntity livingEntity) {
        if (this.isEdible()) {
            return livingEntity.eat(level, itemStack);
        }
        return itemStack;
    }

    public final int getMaxStackSize() {
        return this.maxStackSize;
    }

    public final int getMaxDamage() {
        return this.maxDamage;
    }

    public boolean canBeDepleted() {
        return this.maxDamage > 0;
    }

    public boolean isBarVisible(ItemStack itemStack) {
        return itemStack.isDamaged();
    }

    public int getBarWidth(ItemStack itemStack) {
        return Math.round(13.0f - (float)itemStack.getDamageValue() * 13.0f / (float)this.maxDamage);
    }

    public int getBarColor(ItemStack itemStack) {
        float f = Math.max(0.0f, ((float)this.maxDamage - (float)itemStack.getDamageValue()) / (float)this.maxDamage);
        return Mth.hsvToRgb(f / 3.0f, 1.0f, 1.0f);
    }

    public boolean overrideStackedOnOther(ItemStack itemStack, Slot slot, ClickAction clickAction, Player player) {
        return false;
    }

    public boolean overrideOtherStackedOnMe(ItemStack itemStack, ItemStack itemStack2, Slot slot, ClickAction clickAction, Player player, SlotAccess slotAccess) {
        return false;
    }

    public boolean hurtEnemy(ItemStack itemStack, LivingEntity livingEntity, LivingEntity livingEntity2) {
        return false;
    }

    public boolean mineBlock(ItemStack itemStack, Level level, BlockState blockState, BlockPos blockPos, LivingEntity livingEntity) {
        return false;
    }

    public boolean isCorrectToolForDrops(BlockState blockState) {
        return false;
    }

    public InteractionResult interactLivingEntity(ItemStack itemStack, Player player, LivingEntity livingEntity, InteractionHand interactionHand) {
        return InteractionResult.PASS;
    }

    public Component getDescription() {
        return Component.translatable(this.getDescriptionId());
    }

    public String toString() {
        return BuiltInRegistries.ITEM.getKey(this).getPath();
    }

    protected String getOrCreateDescriptionId() {
        if (this.descriptionId == null) {
            this.descriptionId = Util.makeDescriptionId("item", BuiltInRegistries.ITEM.getKey(this));
        }
        return this.descriptionId;
    }

    public String getDescriptionId() {
        return this.getOrCreateDescriptionId();
    }

    public String getDescriptionId(ItemStack itemStack) {
        return this.getDescriptionId();
    }

    public boolean shouldOverrideMultiplayerNbt() {
        return true;
    }

    @Nullable
    public final Item getCraftingRemainingItem() {
        return this.craftingRemainingItem;
    }

    public boolean hasCraftingRemainingItem() {
        return this.craftingRemainingItem != null;
    }

    public void inventoryTick(ItemStack itemStack, Level level, Entity entity, int n, boolean bl) {
    }

    public void onCraftedBy(ItemStack itemStack, Level level, Player player) {
    }

    public boolean isComplex() {
        return false;
    }

    public UseAnim getUseAnimation(ItemStack itemStack) {
        return itemStack.getItem().isEdible() ? UseAnim.EAT : UseAnim.NONE;
    }

    public int getUseDuration(ItemStack itemStack) {
        if (itemStack.getItem().isEdible()) {
            return this.getFoodProperties().isFastFood() ? 16 : 32;
        }
        return 0;
    }

    public void releaseUsing(ItemStack itemStack, Level level, LivingEntity livingEntity, int n) {
    }

    public void appendHoverText(ItemStack itemStack, @Nullable Level level, List<Component> list, TooltipFlag tooltipFlag) {
    }

    public Optional<TooltipComponent> getTooltipImage(ItemStack itemStack) {
        return Optional.empty();
    }

    public Component getName(ItemStack itemStack) {
        return Component.translatable(this.getDescriptionId(itemStack));
    }

    public boolean isFoil(ItemStack itemStack) {
        return itemStack.isEnchanted();
    }

    public Rarity getRarity(ItemStack itemStack) {
        if (!itemStack.isEnchanted()) {
            return this.rarity;
        }
        switch (this.rarity) {
            case COMMON: 
            case UNCOMMON: {
                return Rarity.RARE;
            }
            case RARE: {
                return Rarity.EPIC;
            }
        }
        return this.rarity;
    }

    public boolean isEnchantable(ItemStack itemStack) {
        return this.getMaxStackSize() == 1 && this.canBeDepleted();
    }

    protected static BlockHitResult getPlayerPOVHitResult(Level level, Player player, ClipContext.Fluid fluid) {
        float f = player.getXRot();
        float f2 = player.getYRot();
        Vec3 vec3 = player.getEyePosition();
        float f3 = Mth.cos(-f2 * ((float)Math.PI / 180) - (float)Math.PI);
        float f4 = Mth.sin(-f2 * ((float)Math.PI / 180) - (float)Math.PI);
        float f5 = -Mth.cos(-f * ((float)Math.PI / 180));
        float f6 = Mth.sin(-f * ((float)Math.PI / 180));
        float f7 = f4 * f5;
        float f8 = f6;
        float f9 = f3 * f5;
        double d = 5.0;
        Vec3 vec32 = vec3.add((double)f7 * 5.0, (double)f8 * 5.0, (double)f9 * 5.0);
        return level.clip(new ClipContext(vec3, vec32, ClipContext.Block.OUTLINE, fluid, player));
    }

    public int getEnchantmentValue() {
        return 0;
    }

    public boolean isValidRepairItem(ItemStack itemStack, ItemStack itemStack2) {
        return false;
    }

    public Multimap<Attribute, AttributeModifier> getDefaultAttributeModifiers(EquipmentSlot equipmentSlot) {
        return ImmutableMultimap.of();
    }

    public boolean useOnRelease(ItemStack itemStack) {
        return false;
    }

    public ItemStack getDefaultInstance() {
        return new ItemStack(this);
    }

    public boolean isEdible() {
        return this.foodProperties != null;
    }

    @Nullable
    public FoodProperties getFoodProperties() {
        return this.foodProperties;
    }

    public SoundEvent getDrinkingSound() {
        return SoundEvents.GENERIC_DRINK;
    }

    public SoundEvent getEatingSound() {
        return SoundEvents.GENERIC_EAT;
    }

    public boolean isFireResistant() {
        return this.isFireResistant;
    }

    public boolean canBeHurtBy(DamageSource damageSource) {
        return !this.isFireResistant || !damageSource.is(DamageTypeTags.IS_FIRE);
    }

    public boolean canFitInsideContainerItems() {
        return true;
    }

    @Override
    public FeatureFlagSet requiredFeatures() {
        return this.requiredFeatures;
    }
```

1. ### 生命周期与事件回调

   ```java
   //
   public void onUseTick(Level level, LivingEntity livingEntity, ItemStack itemStack, int n) {
   }

   public void onDestroyed(ItemEntity itemEntity) {
   }

   public ItemStack finishUsingItem(ItemStack itemStack, Level level, LivingEntity livingEntity) {
        if (this.isEdible()) {
            return livingEntity.eat(level, itemStack);
        }
        return itemStack;
    }
   ```

   - **作用**：
   - **技术细节**：

1. ### 物品属性与配置

   ```java
   //获取物品的数字ID
   public static int getId(Item item) {
        return item == null ? 0 : BuiltInRegistries.ITEM.getId(item);
    }

   //根据数字ID返回物品
    public static Item byId(int n) {
        return BuiltInRegistries.ITEM.byId(n);
    }
   ```

   - **作用**：
   - **技术细节**：

1. ### 交互与使用行为

   ```java

   ```

   - **作用**：
   - **技术细节**：

1. ### 工具提示与本地化

   ```java

   ```

   - **作用**：
   - **技术细节**：

1. ### 耐久与显示

   ```java

   ```

   - **作用**：
   - **技术细节**：

1. ### 攻击与工具行为

   ```java

   ```

   - **作用**：
   - **技术细节**：

1. ### 食物相关

   ```java

   ```

   - **作用**：
   - **技术细节**：

1. ### 注册与标识

   ```java

   ```

   - **作用**：
   - **技术细节**：

1. ### 特性标志与兼容性

   ```java

   ```

   - **作用**：
   - **技术细节**：

1. ### 工具类辅助方法

   ```java

   ```

   - **作用**：
   - **技术细节**：

### 三，[建造者类](../../../1-Areas/Programming/java/builder类.md)Properties

```java
    public Item(Properties properties) {
        String string;
        this.rarity = properties.rarity;
        this.craftingRemainingItem = properties.craftingRemainingItem;
        this.maxDamage = properties.maxDamage;
        this.maxStackSize = properties.maxStackSize;
        this.foodProperties = properties.foodProperties;
        this.isFireResistant = properties.isFireResistant;
        this.requiredFeatures = properties.requiredFeatures;
        if (SharedConstants.IS_RUNNING_IN_IDE && !(string = this.getClass().getSimpleName()).endsWith("Item")) {
            LOGGER.error("Item classes should end with Item and {} doesn't.", (Object)string);
        }
    }
   public static class Properties {
        int maxStackSize = 64;
        int maxDamage;
        @Nullable
        Item craftingRemainingItem;
        Rarity rarity = Rarity.COMMON;
        @Nullable
        FoodProperties foodProperties;
        boolean isFireResistant;
        FeatureFlagSet requiredFeatures = FeatureFlags.VANILLA_SET;

        public Properties food(FoodProperties foodProperties) {
            this.foodProperties = foodProperties;
            return this;
        }

        public Properties stacksTo(int n) {
            if (this.maxDamage > 0) {
                throw new RuntimeException("Unable to have damage AND stack.");
            }
            this.maxStackSize = n;
            return this;
        }

        public Properties defaultDurability(int n) {
            return this.maxDamage == 0 ? this.durability(n) : this;
        }

        public Properties durability(int n) {
            this.maxDamage = n;
            this.maxStackSize = 1;
            return this;
        }

        public Properties craftRemainder(Item item) {
            this.craftingRemainingItem = item;
            return this;
        }

        public Properties rarity(Rarity rarity) {
            this.rarity = rarity;
            return this;
        }

        public Properties fireResistant() {
            this.isFireResistant = true;
            return this;
        }

        public Properties requiredFeatures(FeatureFlag ... featureFlagArray) {
            this.requiredFeatures = FeatureFlags.REGISTRY.subset(featureFlagArray);
            return this;
        }
    }
```
