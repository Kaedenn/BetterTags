function getTagCounts()
    local result = {}

    for _, tag in pairs(G.GAME.tags) do
        result[tag.key] = (result[tag.key] or 0) + 1
    end
    return result
end 

function generateTagUi()
    if G.HUD_tags then
        for k, v in pairs(G.HUD_tags) do
            v:remove()
            G.HUD_tags[k] = nil
        end
    end
    local counts = getTagCounts()
    local done = {}
    for k, tag in pairs(G.GAME.tags) do
        if not done[tag.key] then
            local tag_sprite_ui = tag:generate_UI()
            tag.count = counts[tag.key]
            G.HUD_tags[#G.HUD_tags+1] = UIBox{
                definition = {n=G.UIT.ROOT, config={align = "cm",padding = 0.05, colour = G.C.CLEAR}, nodes={
                    tag_sprite_ui,
                    {n= G.UIT.C, config={align = "cm"}, nodes={   
                        {n = G.UIT.T, config = {text = 'x', scale = 0.4, colour = G.C.UI.TEXT_LIGHT}},
                        {n = G.UIT.T, config = {text = tag.count, scale = 0.4, colour = G.C.UI.TEXT_LIGHT}},
                    }}
                }},
                config = {
                    align = G.HUD_tags[1] and 'tm' or 'bri',
                    offset = G.HUD_tags[1] and {x=0,y=0} or {x=1.3,y=0},
                    major = G.HUD_tags[1] and G.HUD_tags[#G.HUD_tags] or G.ROOM_ATTACH
                }
            }
            done[tag.key] = true
        end
        
    end
end 