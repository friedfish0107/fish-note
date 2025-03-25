# Forge 能量 #forge #mod

>最后更新：2025-03-23 00:10

- forge内置了一套能量系统，称为FE(Forge Energy)，位于`net.minecraftforge.energy`，开发者可以借助FE系统便捷的构建联动性强的模组，以下是其基本介绍

## 基础构成

- FE包由三个文件组成，接口`IEnergyStorage.class`,空FE类`EmptyEnergyStorage.class`,和实现功能的`EnergyStorage.class`

    ```mermaid
    graph LR
    energy --> IEnergyStorage.class
    energy --> EmptyEnergyStorage.class
    energy --> EnergyStorage.class
    ```

## 使用方式

使用时，一般通过在类中设定私有属性并调用，不直接继承

`EnergyStorage` 共有四个属性和八个方法，分别是

- 属性：
    1. `capacity` ：容量
    2. `maxReceive` ：最大输入量
    3. `maxExtract` ：最大消耗量
    4. `energy` ：当前能量
- 方法：
    1. `int` `receiveEnergy(int maxReceive, boolean simulate)`：增加能量，`maxReceive` 为本次传输值(实际会受自身限制和剩余容量等改变)`simulate` 为是否为模拟结果(不实际传输，但有返回值)，返回本次传输的能量
    2. `int` `extractEnergy(int maxExtract, boolean simulate)`提取能量，参数如上
    3. `int` `getEnergyStored()`：获取当前能量
    4. `int` `getMaxEnergyStored()`：获取最大容量
    5. `boolean` `canExtract()`：判断是否能消耗(最大消耗量>0)
    6. `boolean` `canReceive()`：判断是否能输入(最大输入量>0)
    7. `Tag` `serializeNBT()`：将当前能量以nbt形式返回
    8. `void` `deserializeNBT(Tag nbt)`：将修改的nbt同步为能量(如果该nbt不是整数形式则掷出`IllegalArgumentException` 类型错误`"Can not deserialize to an instance that isn't the default implementation"`)

实际应用

- 暂无
