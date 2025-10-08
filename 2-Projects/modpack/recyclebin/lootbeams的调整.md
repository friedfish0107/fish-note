# Loot Beams的调整

>最后更新：2025-10-07 01:45

`.\config\lootbeams-client.toml`

更改内容:

- 增加光柱渲染的距离
- 不渲染工具提示以节省性能
- 所有物品渲染光柱

```toml
    #Beam Configuration
    ["Loot Beams".Beam]
        #Range: 0.0 ~ 100.0
        beam_fade_distance = 12.0# 2.0->12.0
    
    #Item Config
    ["Loot Beams".Items]
        #If all Items Loot Beams should be rendered. Has priority over only_equipment and only_rare.
        all_items = true# false->true

    ["Loot Beams".Nametags]
        #If vanilla tooltips should be rendered on items in world.
        advanced_tooltips = false# true->false
```
