
fill 976 -61 976 1023 -61 1023 white_concrete

fill 976 -61 1023 1007 -61 1055 magenta_concrete

#tellraw @a

#playsound random.orb @a[y=-59,r=2.5,tag=!red] ~ -59 ~
#tellraw @a[y=-59,r=2.5,tag=!red] {"rawtext":[{"text":"§c你已加入红队"}]}
#tag @a[y=-59,r=2.5,tag=blue] remove blue
#tag @a[y=-59,r=2.5,tag=!red] add red

#playsound random.orb @a[y=-59,r=2.5,tag=!blue] ~ -59 ~
#tellraw @a[y=-59,r=2.5,tag=!blue] {"rawtext":[{"text":"§b你已加入蓝队"}]}
#tag @a[y=-59,r=2.5,tag=red] remove red
#tag @a[y=-59,r=2.5,tag=!blue] add blue

clone ~ ~6 ~ ~ ~6 ~ ~ ~4 ~
setblock ~ ~5 ~ air destroy

scoreboard objectives add character dummy

scoreboard players set @p[y=-52] character 1

tp @p[y=-51] 12 -59 -19

execute as @p if entity @s[scores={character=0}] run tp @s ~ ~7 ~

execute as @a at @s run fill ~-16 -61 ~-16 ~16 -61 ~16 grass_block keep

fill ~-63 -61 ~-63 ~63 -61 ~63 gray_concrete
