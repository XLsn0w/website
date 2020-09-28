require "TSLib"
local a={{185,687,0xcbcbcb},
    {200,683,0x000000},
    {200,700,0x000000},
    {226,675,0x000000},
    {251,706,0x000000},
}
local x,y=findMultiColorInRegionFuzzyByTable(a,90,166,626,440,890,{orient =1})
dialog(x..","..y,5)
