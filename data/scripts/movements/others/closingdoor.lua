local closingDoor = MoveEvent()
closingDoor:type("stepout")

function closingDoor.onStepOut(creature, item, position, fromPosition)
    local tile = Tile(position)
    if tile:getCreatureCount() > 0 then
        return true
    end

    local newPosition = {x = position.x + 1, y = position.y, z = position.z}
    local query = Tile(newPosition):queryAdd(creature)
    if query ~= RETURNVALUE_NOERROR or query == RETURNVALUE_NOTENOUGHROOM then
        newPosition.x = newPosition.x - 1
        newPosition.y = newPosition.y + 1
        query = Tile(newPosition):queryAdd(creature)
    end

    if query == RETURNVALUE_NOERROR or query ~= RETURNVALUE_NOTENOUGHROOM then
        doRelocate(position, newPosition)
    end

    local i, tileItem, tileCount = 1, true, tile:getThingCount()
    while tileItem and i < tileCount do
        tileItem = tile:getThing(i)
        if tileItem and tileItem:getUniqueId() ~= item.uid and tileItem:getType():isMovable() then
            tileItem:remove()
        else
            i = i + 1
        end
    end

    item:transform(item.itemid - 1)
    return true
end

-- Closing doors (open doors that close when stepped out)
closingDoor:id(1211, 1214, 1217, 1220, 1223, 1226, 1229, 1232, 1235, 1238, 1241, 1244, 1247, 1250, 1253, 1256, 1259, 5100, 5102, 5104, 5106, 5108, 5110, 5112, 5114, 5116, 5118, 5120, 5122, 5124, 5126, 5128, 5130, 5132, 5134, 5136, 5138, 5140, 5142, 5144, 5146, 5148, 5150, 5152, 5154, 5156, 5158, 5160, 5162, 5164, 5166, 5168, 5170, 5172, 5174, 5176, 5178, 5180, 5182, 5184, 5186, 5188, 5190, 5192, 5194, 5196, 5198, 5200, 5202, 5204, 5206, 5208, 5210, 5212, 5214, 5216, 5218, 5220, 5222, 5224, 5226, 5228, 5230, 5232, 5234, 5236, 5238, 5240, 5242, 5244, 5246, 5248, 5250, 5252, 5254, 5256, 5258, 5260, 5262, 5264, 5266, 5268, 5270, 5272, 5274, 5276, 5278, 5280, 5282, 5284, 5286, 5288, 5290, 5292, 5294, 5296, 5298, 5300, 5302, 5304, 5306, 5308, 5310, 5312, 5314, 5316, 5318, 5320, 5322, 5324, 5326, 5328, 5330, 5332, 5334, 5336, 5338, 5340, 5342, 5344, 5346, 5348, 5350, 5352, 5354, 5356, 5358, 5360, 5362, 5364, 5366, 5368, 5370, 5372, 5374, 5376, 5378, 5380, 5382, 5384, 5386, 5388, 5390, 5392, 5394, 5396, 5398, 5400, 5402, 5404)
closingDoor:register()

