# craftmine #草稿

## 新增

### 音乐/音效

`assets\nothingtoseehere`新增了数个音效和一个`sound.json`

```json
{
  "crowd_start" : {
    "sounds" : [
      "nothingtoseehere:villager_crowd/crowd_start"
    ]
  },
  "crowd_cheer" : {
    "sounds" : [
      "nothingtoseehere:villager_crowd/crowd_cheer"
    ]
  },
  "crowd_waiting" : {
    "sounds" : [
      "nothingtoseehere:villager_crowd/crowd_waiting"
    ]
  },
  "and_action" : {
    "sounds" : [
      "nothingtoseehere:and_action/and_action"
    ]
  },
  "ui.player_unlock_success": {
    "sounds": [
      {
        "name": "block/respawn_anchor/charge1",
        "pitch": 1.5
      },
      {
        "name": "block/respawn_anchor/charge2",
        "pitch": 1.5
      },
      {
        "name": "block/respawn_anchor/charge3",
        "pitch": 1.5
      }
    ]
  },
  "ui.player_unlock_fail": {
    "sounds": [
      "item/shield/block1",
      "item/shield/block2",
      "item/shield/block3",
      "item/shield/block4",
      "item/shield/block5"
    ]
  }
}

```

### 物品

#### 奖杯：`minecraft:trophy`，奖杯，无碰撞箱  

- 获取方式未知
  - 巨型土豆奖杯：获得成就"认证土豆狂魔"(食用100个毒马铃薯)获得
- 不存在价值，可以带回家
- 不存在与创造标签页
- 具有组件`minecraft:trophy/type`  
  - 有三个可选项
  1. `gold`：金杯
  2. `mega_spud`：巨型土豆
  3. `no_medal`：差一点奖章

```text
/data merge block -27 186 365 {Items:[{count:1,Slot:2b,id:"minecraft:trophy",components:{"minecraft:trophy/type":"no_medal"}}]}
```

#### 闪烁钥匙：`shimmering_key`

- 获取方式：通关特殊矿井
  - 注：获得"迷宫"钥匙的概率只有其他钥匙的一半
- 存在于功能方块
- 具有组件`minecraft:instant_room`，其内容是一对键值对`{"structure": "minecraft:..."}`，可使用内容如下：

`/give @s minecraft:shimmering_key[minecraft:instant_room={"structure":"minecraft:barrels"}]`

```json
    "room.minecraft.barrels": "储藏室（木桶）",
    "room.minecraft.boiler": "锅炉房",
    "room.minecraft.carpet": "休闲室",
    "room.minecraft.corridor_simple": "无聊走廊",
    "room.minecraft.fountain": "喷泉",
    "room.minecraft.grassy_h": "交叉口（草地）",
    "room.minecraft.hanging": "储藏室（悬挂木桶）",
    "room.minecraft.house": "哇，这价格能买整栋房子？",
    "room.minecraft.labyrinth": "迷宫",
    "room.minecraft.pool": "深水池",
    "room.minecraft.ship": "船",
    "room.minecraft.simple": "测试房间请忽略",
    "room.minecraft.stairs": "楼梯",
    "room.minecraft.storage1": "储藏室（简易）",
    "room.minecraft.storage2": "储藏室（复杂）",
    "room.minecraft.sugar_h": "交叉口（甘蔗）",
    "room.minecraft.tree": "树",
    "room.minecraft.trophy": "复古奖杯室",
    "room.minecraft.tunnel": "直线",
    "room.minecraft.useless": "无用房间",
    "room.minecraft.wheat_h": "交叉口（小麦）",
    "room.minecraft.workshop": "工作间",
```

- 介绍：
  - 锅炉房中有一个维度控制器和一个装了所有天空盒的箱子

### 未知内容

`assets\minecraft\textures\environment\skynorama`放置了几张矿井起点的图片
`assets\minecraft\textures\gui\container\mine_crafter_won.png"`似乎是通关的图片，可能是解锁全部矿井材料，可能是奖杯的获取途径
`assets\minecraft\textures\gui\sprites\widget\window.png"`存储了一张窗户图片
`assets\minecraft\textures\misc\map_lost_glint.png"`和同路径下的`map_won_glint.png`用红色和绿色的线条随意绘制

## 删除

## 改动

现在猪可以吃金胡萝卜了，第一次给猪喂食金胡萝卜可以获得矿井材料-猪灵
