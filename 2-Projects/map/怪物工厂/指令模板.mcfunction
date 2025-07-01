
/titleraw @p actionbar {"rawtext":[{"text":"§e生命 §b当前值: §c"},{"score":{"name":"health","objective":"config"}},{"text":"§d | §a默认值: 5"}]}
/scoreboard players add health config 1
/scoreboard players remove health config 1
/scoreboard players operation health config = health defaultconfig
/scoreboard players set health defaultconfig 5

/titleraw @p actionbar {"rawtext":[{"text":"§e初始金币 §b当前值: §c"},{"score":{"name":"initial_money","objective":"config"}},{"text":"§d | §a默认值: 50"}]}
/scoreboard players add initial_money config 5
/scoreboard players remove initial_money config 5
/scoreboard players operation initial_money config = initial_money defaultconfig
/scoreboard players set initial_money defaultconfig 50

/scoreboard players operation §c红队生命 team = health config
/scoreboard players operation §b蓝队生命 team = health config
/scoreboard players set §b蓝队生命 team -1

/scoreboard players operation §c红队金币 team = initial_money config
/scoreboard players operation §b蓝队金币 team = initial_money config
/scoreboard players set §c红队金币 team -1
/scoreboard players set §b蓝队金币 team -1

/titleraw @p actionbar {"rawtext":[{"text":"§e金币生产间隔 §b当前值: §c"},{"score":{"name":"money_add_interval","objective":"config"}},{"text":"§d | §a默认值: "},{"score":{"name":"money_add_interval","objective":"defaultconfig"}}]}
/scoreboard players add money_add_interval config 1
/scoreboard players remove money_add_interval config 1
/scoreboard players operation money_add_interval config = money_add_interval defaultconfig
/scoreboard players set money_add_interval defaultconfig 10

/titleraw @p actionbar {"rawtext":[{"text":"§e金币生产量 §b当前值: §c"},{"score":{"name":"money_add_amount","objective":"config"}},{"text":"§d | §a默认值: "},{"score":{"name":"money_add_amount","objective":"defaultconfig"}}]}
/scoreboard players add money_add_amount config 1
/scoreboard players remove money_add_amount config 1
/scoreboard players operation money_add_amount config = money_add_amount defaultconfig
/scoreboard players set money_add_amount defaultconfig 2

/scoreboard players operation money_cd time = money_add_interval config

/scoreboard players set enabled_night config 1

/scoreboard players operation day_time time = day_time config
/scoreboard players operation day_time time = night_time config

/titleraw @p actionbar {"rawtext":[{"text":"§e白日时间 §b当前值: §c"},{"score":{"name":"day_time","objective":"config"}},{"text":"§d | §a默认值: "},{"score":{"name":"day_time","objective":"defaultconfig"}}]}
/scoreboard players add day_time config 100
/scoreboard players remove day_time config 100
/scoreboard players operation day_time config = day_time defaultconfig
/scoreboard players set day_time defaultconfig 1200

/titleraw @p actionbar {"rawtext":[{"text":"§e夜晚时间 §b当前值: §c"},{"score":{"name":"night_time","objective":"config"}},{"text":"§d | §a默认值: "},{"score":{"name":"night_time","objective":"defaultconfig"}}]}
/scoreboard players add night_time config 100
/scoreboard players remove night_time config 100
/scoreboard players operation night_time config = night_time defaultconfig
/scoreboard players set night_time defaultconfig 900

/execute if score enabled_night config matches 1 run scoreboard players remove day_time time 1
/execute if score enabled_night config matches 1 run setblock
/execute if score day_time time matches ..0 run setblock ~~1~ chain_command_block 1
/setblock ~~~ chain_command_block 0

/execute if score isDay flag matches 0 run setblock ~~1~ chain_command_block 3
/scoreboard players set isDay flag 0

/scoreboard objectives add flag dummy
/scoreboard objectives setdisplay sidebar percentage

/scoreboard objectives add max_score dummy
/scoreboard objectives add score dummy
/scoreboard objectives add const dummy
/scoreboard objectives add percentage dummy
/scoreboard objectives add unit_percentage dummy
/scoreboard objectives add ten_digit_percentage dummy

/tag @e[type=armor_stand,c=1] add track

/scoreboard players set @e[type=armor_stand,tag=track] max_score 150
/scoreboard players set @e[type=armor_stand,tag=track] score 65

/scoreboard players set I10 const 9
/scoreboard players set I100 const 81

/execute as @e[type=armor_stand,tag=track] run scoreboard players operation @s percentage = @s score
/execute as @e[type=armor_stand,tag=track] run scoreboard players operation @s percentage *= I100 const
/execute as @e[type=armor_stand,tag=track] run scoreboard players operation @s percentage /= @s max_score

/execute as @e[type=armor_stand,tag=track] run scoreboard players operation @s unit_percentage = @s percentage
/execute as @e[type=armor_stand,tag=track] run scoreboard players operation @s unit_percentage %= I10 const
/execute as @e[type=armor_stand,tag=track] run scoreboard players operation @s ten_digit_percentage = @s percentage
/execute as @e[type=armor_stand,tag=track] run scoreboard players operation @s ten_digit_percentage /= I10 const

/execute as @e[type=armor_stand,tag=track] at @s run titleraw @p actionbar {"rawtext":[{"score":{"name":"@s","objective":"score"}},{"text":" / "},{"score":{"name":"@s","objective":"max_score"}},{"text":"  "},{"translate":"%%9","with":{"rawtext":[{"selector":"@s[scores={ten_digit_percentage=8..}]"},{"selector":"@s[scores={ten_digit_percentage=7..}]"},{"selector":"@s[scores={ten_digit_percentage=6..}]"},{"selector":"@s[scores={ten_digit_percentage=5..}]"},{"selector":"@s[scores={ten_digit_percentage=4..}]"},{"selector":"@s[scores={ten_digit_percentage=3..}]"},{"selector":"@s[scores={ten_digit_percentage=2..}]"},{"selector":"@s[scores={ten_digit_percentage=1..}]"},{"text":"||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"},{"text":"|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||         "},{"text":"||||||||||||||||||||||||||||||||||||||||||||||||||||||                  "},{"text":"|||||||||||||||||||||||||||||||||||||||||||||                           "},{"text":"||||||||||||||||||||||||||||||||||||                                    "},{"text":"|||||||||||||||||||||||||||                                             "},{"text":"||||||||||||||||||                                                      "},{"text":"|||||||||                                                               "}]}},{"translate":"%%9","with":{"rawtext":[{"selector":"@s[scores={unit_percentage=8..}]"},{"selector":"@s[scores={unit_percentage=7..}]"},{"selector":"@s[scores={unit_percentage=6..}]"},{"selector":"@s[scores={unit_percentage=5..}]"},{"selector":"@s[scores={unit_percentage=4..}]"},{"selector":"@s[scores={unit_percentage=3..}]"},{"selector":"@s[scores={unit_percentage=2..}]"},{"selector":"@s[scores={unit_percentage=1..}]"},{"text":"||||||||"},{"text":"||||||| "},{"text":"||||||  "},{"text":"|||||   "},{"text":"||||    "},{"text":"|||     "},{"text":"||      "},{"text":"|       "}]}}]}



/say @e[type=armor_stand,tag=track,scores={unit_percentage=..4}]

evil ‮ gpj.exe



‎从左至右标志
‏从右至左标志
‪‫‬‭‮

ࡀ
