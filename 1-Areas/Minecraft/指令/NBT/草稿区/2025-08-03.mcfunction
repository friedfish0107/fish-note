execute rotated as @e[name=tree] positioned ^ ^ ^4 rotated as @e[name=tree] positioned ^ ^ ^2 rotated as @e[name=tree] positioned ^ ^ ^1 rotated as @e[name=tree] positioned ^ ^ ^0.5 run particle minecraft:endrod

execute rotated as @e[name=tree] positioned ^ ^ ^0.5 rotated as @e[name=tree] positioned ^ ^ ^1 rotated as @e[name=tree] positioned ^ ^ ^2 rotated as @e[name=tree] positioned ^ ^ ^4 run particle minecraft:endrod

execute rotated as @e[name=tree] positioned ^ ^ ^4 align xyz positioned as @e[name=tree] positioned ^ ^ ^2 align xyz run particle minecraft:endrod

execute rotated as @e[name=tree] positioned ^ ^ ^4 rotated as @e[name=tree] positioned ^ ^ ^2 rotated as @e[name=tree] positioned ^4 ^ ^ rotated as @e[name=tree] positioned ^2 ^ ^ rotated as @e[tag=up] positioned ^ ^ ^4 rotated as @e[tag=up] positioned ^ ^ ^2 run particle minecraft:endrod

execute positioned ~0.5 -59 ~0.5 rotated as @e[name=tree] positioned ^ ^ ^4 rotated as @e[name=tree] positioned ^ ^ ^2 rotated as @e[name=tree] positioned ^ ^ ^1 rotated as @e[name=tree] positioned ^ ^ ^0.5 rotated as @e[name=tree] positioned ^4 ^ ^ rotated as @e[name=tree] positioned ^2 ^ ^ rotated as @e[name=tree] positioned ^1 ^ ^ rotated as @e[name=tree] positioned ^0.5 ^ ^ rotated as @p positioned ^ ^ ^0.5 facing entity @e[name=door] feet positioned ^-10000 ^ ^ if entity @p[r=10000] positioned ^10000 ^ ^ facing entity @e[name=door2] feet positioned ^10000 ^ ^ if entity @p[r=10000] positioned ^-10000 ^ ^ run clone ~-30 ~-1 ~ ~-30 ~5 ~ ~ ~-1 ~