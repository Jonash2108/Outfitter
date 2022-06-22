-- By: Bassrex100 | Credit to GhostOne's Head Blend script & Kektram's Weapon Mapper
-- Version: 3.1.1 | Last Updated May 19th 2022

if OutfitterLoaded then
    menu.notify("Outfitter.lua is already loaded.", "Lua Script", 10, 0xff0000ff)
    return
end
OutfitterLoaded = true

-- Tables
    local o <const>, Stat <const>, Attachment <const> = {
        config = {},
        folders = {},
        refresh = true,
        respawn = false,
        pid = player.player_id,
        add_feature = menu.add_feature,
        get_ped = player.get_player_ped,
        get_model = player.get_player_model,
        delete_feature = menu.delete_feature,
        get_prop_variation = ped.get_ped_prop_index,
        get_comp_texture = ped.get_ped_texture_variation,
        get_prop_texture = ped.get_ped_prop_texture_index,
        get_comp_variation = ped.get_ped_drawable_variation,
        get_max_prop_textures = ped.get_number_of_ped_prop_texture_variations,
        directory = utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Outfitter.lua saves", ""),
        all_sections = {"COMPONENTS","COMPONENTS_TEXTURES","PROPERTIES","PROPERTIES_TEXTURES","HEAD_OVERLAYS","HEAD_BLEND","FACE_FEATURES","MODEL","STATS"}
    }, {
        [0] = {
            ["Type"] = "Bool",
            ["Name"] = "IS_VISOR_UP",
            ["Data"] = {"Down","Up"}
        },
        [1] = {
            ["Type"] = "Int",
            ["Name"] = "PARACHUTE_CURRENT_PACK",
            ["Data"] = {"Classic","USA","Australia","Brazil","Spain","Canada","France","Germany","Japan","Scotland","United Kingdom","Italy","Switzerland","High Flyer","Jamaica","Colombia","Norway","Sweden","Belgium","Mexico","Austria","Russian Federation","Argentina","Turkey","Ireland","Wales","England","Finland","Denmark","Netherlands","Portugal","China","Croatia","Czech Republic","Hungary","Liechtenstein","Malta","New Zealand","Nigeria","Poland","Puerto Rico","Slovakia","Slovenia","South Africa","South Korea","Palestine","Israel","Black Combat","Gray Combat","Charcoal Combat","Tan Combat","Forest Combat","Green Team","Orange Team","Orange Team","Purple Team","Pink Team","Red Team","Blue Team","Grey Team","Tan Team","White Team","India","Pakistan","Sprunk","Halloween","eCola"}
        },
        [2] = {
            ["Type"] = "Int",
            ["Name"] = "PARACHUTE_CURRENT_TINT",
            ["Data"] = {"Rainbow","Red","Seaside Stripes","Widowmaker","Patriot","Blue","Black","Hornet","Air Force","Desert","Shadow","High Altitude","Airborne","Sunrise","Sprunk","eCola","Halloween"}
        },
        [3] = {
            ["Type"] = "Int",
            ["Name"] = "ILLUMINATED_CLOTHING",
            ["Data"] = {"On","Flash","Pulse","Off"}
        }
    }, {
        [gameplay.get_hash_key("weapon_raypistol")] = {"RAYPISTOL_VARMOD_XMAS18"},
        [gameplay.get_hash_key("weapon_revolver")] = {"REVOLVER_VARMOD_BOSS","REVOLVER_VARMOD_GOON","REVOLVER_CLIP_01"},
        [gameplay.get_hash_key("weapon_vintagepistol")] = {"VINTAGEPISTOL_CLIP_01","VINTAGEPISTOL_CLIP_02","AT_PI_SUPP"},
        [gameplay.get_hash_key("weapon_snspistol")] = {"SNSPISTOL_CLIP_01","SNSPISTOL_CLIP_02","SNSPISTOL_VARMOD_LOWRIDER"},
        [gameplay.get_hash_key("weapon_ceramicpistol")] = {"CERAMICPISTOL_CLIP_01","CERAMICPISTOL_CLIP_02","CERAMICPISTOL_SUPP"},
        [gameplay.get_hash_key("weapon_pistol")] = {"PISTOL_CLIP_01","PISTOL_CLIP_02","AT_PI_FLSH","AT_PI_SUPP_02","PISTOL_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_appistol")] = {"APPISTOL_CLIP_01","APPISTOL_CLIP_02","AT_PI_FLSH","AT_PI_SUPP","APPISTOL_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_pistol50")] = {"PISTOL50_CLIP_01","PISTOL50_CLIP_02","AT_PI_FLSH","AT_AR_SUPP_02","PISTOL50_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_heavypistol")] = {"HEAVYPISTOL_CLIP_01","HEAVYPISTOL_CLIP_02","AT_PI_FLSH","AT_PI_SUPP","HEAVYPISTOL_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_combatpistol")] = {"COMBATPISTOL_CLIP_01","COMBATPISTOL_CLIP_02","AT_PI_FLSH","AT_PI_SUPP","COMBATPISTOL_VARMOD_LOWRIDER"},
        [gameplay.get_hash_key("weapon_revolver_mk2")] = {"REVOLVER_MK2_CLIP_01","REVOLVER_MK2_CLIP_TRACER","REVOLVER_MK2_CLIP_INCENDIARY","REVOLVER_MK2_CLIP_HOLLOWPOINT","REVOLVER_MK2_CLIP_FMJ","AT_SIGHTS","AT_SCOPE_MACRO_MK2","AT_PI_FLSH","AT_PI_COMP_03"},
        [gameplay.get_hash_key("weapon_pistol_mk2")] = {"PISTOL_MK2_CLIP_01","PISTOL_MK2_CLIP_02","PISTOL_MK2_CLIP_TRACER","PISTOL_MK2_CLIP_INCENDIARY","PISTOL_MK2_CLIP_HOLLOWPOINT","PISTOL_MK2_CLIP_FMJ","AT_PI_RAIL","AT_PI_FLSH_02","AT_PI_SUPP_02","AT_PI_COMP"},
        [gameplay.get_hash_key("weapon_snspistol_mk2")] = {"SNSPISTOL_MK2_CLIP_01","SNSPISTOL_MK2_CLIP_02","SNSPISTOL_MK2_CLIP_TRACER","SNSPISTOL_MK2_CLIP_INCENDIARY","SNSPISTOL_MK2_CLIP_HOLLOWPOINT","SNSPISTOL_MK2_CLIP_FMJ","AT_PI_FLSH_03","AT_PI_RAIL_02","AT_PI_SUPP_02","AT_PI_COMP_02"},

        [gameplay.get_hash_key("weapon_minismg")] = {"MINISMG_CLIP_01","MINISMG_CLIP_02"},
        [gameplay.get_hash_key("weapon_gusenberg")] = {"GUSENBERG_CLIP_01","GUSENBERG_CLIP_02"},
        [gameplay.get_hash_key("weapon_mg")] = {"MG_CLIP_01","MG_CLIP_02","AT_SCOPE_SMALL_02","MG_VARMOD_LOWRIDER"},
        [gameplay.get_hash_key("weapon_machinepistol")] = {"MACHINEPISTOL_CLIP_01","MACHINEPISTOL_CLIP_02","MACHINEPISTOL_CLIP_03","AT_PI_SUPP"},
        [gameplay.get_hash_key("weapon_combatmg")] = {"COMBATMG_CLIP_01","COMBATMG_CLIP_02","AT_SCOPE_MEDIUM","AT_AR_AFGRIP","COMBATMG_VARMOD_LOWRIDER"},
        [gameplay.get_hash_key("weapon_smg")] = {"SMG_CLIP_01","SMG_CLIP_02","SMG_CLIP_03","AT_AR_FLSH","AT_SCOPE_MACRO_02","AT_PI_SUPP","SMG_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_combatpdw")] = {"COMBATPDW_CLIP_01","COMBATPDW_CLIP_02","COMBATPDW_CLIP_03","AT_AR_FLSH","AT_AR_AFGRIP","AT_SCOPE_SMALL"},
        [gameplay.get_hash_key("weapon_microsmg")] = {"MICROSMG_CLIP_01","MICROSMG_CLIP_02","AT_PI_FLSH","AT_SCOPE_MACRO","AT_AR_SUPP_02","MICROSMG_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_assaultsmg")] = {"ASSAULTSMG_CLIP_01","ASSAULTSMG_CLIP_02","AT_AR_FLSH","AT_SCOPE_MACRO","AT_AR_SUPP_02","ASSAULTSMG_VARMOD_LOWRIDER"},
        [gameplay.get_hash_key("weapon_combatmg_mk2")] = {"COMBATMG_MK2_CLIP_01","COMBATMG_MK2_CLIP_02","COMBATMG_MK2_CLIP_TRACER","COMBATMG_MK2_CLIP_INCENDIARY","COMBATMG_MK2_CLIP_ARMORPIERCING","COMBATMG_MK2_CLIP_FMJ","AT_AR_AFGRIP_02","AT_SIGHTS","AT_SCOPE_SMALL_MK2","AT_SCOPE_MEDIUM_MK2","AT_MUZZLE_01","AT_MUZZLE_02","AT_MUZZLE_03","AT_MUZZLE_04","AT_MUZZLE_05","AT_MUZZLE_06","AT_MUZZLE_07","AT_MG_BARREL_01","AT_MG_BARREL_02"},

        [gameplay.get_hash_key("weapon_compactrifle")] = {"COMPACTRIFLE_CLIP_01","COMPACTRIFLE_CLIP_02","COMPACTRIFLE_CLIP_03"},
        [gameplay.get_hash_key("weapon_militaryrifle")] = {"MILITARYRIFLE_CLIP_01","MILITARYRIFLE_CLIP_02","MILITARYRIFLE_SIGHT_01","AT_SCOPE_SMALL","AT_AR_FLSH","AT_AR_SUPP"},
        [gameplay.get_hash_key("weapon_advancedrifle")] = {"ADVANCEDRIFLE_CLIP_01","ADVANCEDRIFLE_CLIP_02","AT_AR_FLSH","AT_SCOPE_SMALL","AT_AR_SUPP","ADVANCEDRIFLE_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_bullpuprifle")] = {"BULLPUPRIFLE_CLIP_01","BULLPUPRIFLE_CLIP_02","AT_AR_FLSH","AT_SCOPE_SMALL","AT_AR_SUPP","AT_AR_AFGRIP","BULLPUPRIFLE_VARMOD_LOW"},
        [gameplay.get_hash_key("weapon_heavyrifle")] = {"HEAVYRIFLE_CLIP_01","HEAVYRIFLE_CLIP_02","HEAVYRIFLE_SIGHT_01","AT_SCOPE_MEDIUM","AT_AR_FLSH","AT_AR_SUPP","AT_AR_AFGRIP","HEAVYRIFLE_CAMO1"},
        [gameplay.get_hash_key("weapon_carbinerifle")] = {"CARBINERIFLE_CLIP_01","CARBINERIFLE_CLIP_02","CARBINERIFLE_CLIP_03","AT_AR_FLSH","AT_SCOPE_MEDIUM","AT_AR_SUPP","AT_AR_AFGRIP","CARBINERIFLE_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_assaultrifle")] = {"ASSAULTRIFLE_CLIP_01","ASSAULTRIFLE_CLIP_02","ASSAULTRIFLE_CLIP_03","AT_AR_FLSH","AT_SCOPE_MACRO","AT_AR_SUPP_02","AT_AR_AFGRIP","ASSAULTRIFLE_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_specialcarbine")] = {"SPECIALCARBINE_CLIP_01","SPECIALCARBINE_CLIP_02","SPECIALCARBINE_CLIP_03","AT_AR_FLSH","AT_SCOPE_MEDIUM","AT_AR_SUPP_02","AT_AR_AFGRIP","SPECIALCARBINE_VARMOD_LOWRIDER"},
        [gameplay.get_hash_key("weapon_bullpuprifle_mk2")] = {"BULLPUPRIFLE_MK2_CLIP_01","BULLPUPRIFLE_MK2_CLIP_02","BULLPUPRIFLE_MK2_CLIP_TRACER","BULLPUPRIFLE_MK2_CLIP_INCENDIARY","BULLPUPRIFLE_MK2_CLIP_ARMORPIERCING","BULLPUPRIFLE_MK2_CLIP_FMJ","AT_AR_FLSH","AT_SIGHTS","AT_SCOPE_MACRO_02_MK2","AT_SCOPE_SMALL_MK2","AT_BP_BARREL_01","AT_BP_BARREL_02","AT_AR_SUPP","AT_MUZZLE_01","AT_MUZZLE_02","AT_MUZZLE_03","AT_MUZZLE_04","AT_MUZZLE_05","AT_MUZZLE_06","AT_MUZZLE_07","AT_AR_AFGRIP_02"},
        [gameplay.get_hash_key("weapon_assaultrifle_mk2")] = {"ASSAULTRIFLE_MK2_CLIP_01","ASSAULTRIFLE_MK2_CLIP_02","ASSAULTRIFLE_MK2_CLIP_TRACER","ASSAULTRIFLE_MK2_CLIP_INCENDIARY","ASSAULTRIFLE_MK2_CLIP_ARMORPIERCING","ASSAULTRIFLE_MK2_CLIP_FMJ","AT_AR_AFGRIP_02","AT_AR_FLSH","AT_SIGHTS","AT_SCOPE_MACRO_MK2","AT_SCOPE_MEDIUM_MK2","AT_AR_SUPP_02","AT_MUZZLE_01","AT_MUZZLE_02","AT_MUZZLE_03","AT_MUZZLE_04","AT_MUZZLE_05","AT_MUZZLE_06","AT_MUZZLE_07","AT_AR_BARREL_01","AT_AR_BARREL_02"},
        [gameplay.get_hash_key("weapon_specialcarbine_mk2")] = {"SPECIALCARBINE_MK2_CLIP_01","SPECIALCARBINE_MK2_CLIP_02","SPECIALCARBINE_MK2_CLIP_TRACER","SPECIALCARBINE_MK2_CLIP_INCENDIARY","SPECIALCARBINE_MK2_CLIP_ARMORPIERCING","SPECIALCARBINE_MK2_CLIP_FMJ","AT_AR_FLSH","AT_SIGHTS","AT_SCOPE_MACRO_MK2","AT_SCOPE_MEDIUM_MK2","AT_AR_SUPP_02","AT_MUZZLE_01","AT_MUZZLE_02","AT_MUZZLE_03","AT_MUZZLE_04","AT_MUZZLE_05","AT_MUZZLE_06","AT_MUZZLE_07","AT_AR_AFGRIP_02","AT_SC_BARREL_01","AT_SC_BARREL_02"},
        [gameplay.get_hash_key("weapon_carbinerifle_mk2")] = {"CARBINERIFLE_MK2_CLIP_01","CARBINERIFLE_MK2_CLIP_02","CARBINERIFLE_MK2_CLIP_TRACER","CARBINERIFLE_MK2_CLIP_INCENDIARY","CARBINERIFLE_MK2_CLIP_ARMORPIERCING","CARBINERIFLE_MK2_CLIP_FMJ","AT_AR_AFGRIP_02","AT_AR_FLSH","AT_SIGHTS","AT_SCOPE_MACRO_MK2","AT_SCOPE_MEDIUM_MK2","AT_AR_SUPP","AT_MUZZLE_01","AT_MUZZLE_02","AT_MUZZLE_03","AT_MUZZLE_04","AT_MUZZLE_05","AT_MUZZLE_06","AT_MUZZLE_07","AT_CR_BARREL_01","AT_CR_BARREL_02","CARBINERIFLE_MK2_CAMO"},

        [gameplay.get_hash_key("weapon_heavysniper")] = {"HEAVYSNIPER_CLIP_01","AT_SCOPE_LARGE","AT_SCOPE_MAX"},
        [gameplay.get_hash_key("weapon_sniperrifle")] = {"SNIPERRIFLE_CLIP_01","AT_AR_SUPP_02","AT_SCOPE_LARGE","AT_SCOPE_MAX","SNIPERRIFLE_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_marksmanrifle")] = {"MARKSMANRIFLE_CLIP_01","MARKSMANRIFLE_CLIP_02","AT_SCOPE_LARGE_FIXED_ZOOM","AT_AR_FLSH","AT_AR_SUPP","AT_AR_AFGRIP","MARKSMANRIFLE_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_heavysniper_mk2")] = {"HEAVYSNIPER_MK2_CLIP_01","HEAVYSNIPER_MK2_CLIP_02","HEAVYSNIPER_MK2_CLIP_INCENDIARY","HEAVYSNIPER_MK2_CLIP_ARMORPIERCING","HEAVYSNIPER_MK2_CLIP_FMJ","HEAVYSNIPER_MK2_CLIP_EXPLOSIVE","AT_SCOPE_LARGE_MK2","AT_SCOPE_MAX","AT_SCOPE_NV","AT_SCOPE_THERMAL","AT_SR_SUPP_03","AT_MUZZLE_08","AT_MUZZLE_09","AT_SR_BARREL_01","AT_SR_BARREL_02"},
        [gameplay.get_hash_key("weapon_marksmanrifle_mk2")] = {"MARKSMANRIFLE_MK2_CLIP_01","MARKSMANRIFLE_MK2_CLIP_02","MARKSMANRIFLE_MK2_CLIP_TRACER","MARKSMANRIFLE_MK2_CLIP_INCENDIARY","MARKSMANRIFLE_MK2_CLIP_ARMORPIERCING","MARKSMANRIFLE_MK2_CLIP_FMJ","AT_SIGHTS","AT_SCOPE_MEDIUM_MK2","AT_SCOPE_LARGE_FIXED_ZOOM_MK2","AT_AR_FLSH","AT_AR_SUPP","AT_MUZZLE_01","AT_MUZZLE_02","AT_MUZZLE_03","AT_MUZZLE_04","AT_MUZZLE_05","AT_MUZZLE_06","AT_MUZZLE_07","AT_MRFL_BARREL_01","AT_MRFL_BARREL_02","AT_AR_AFGRIP_02"},

        [gameplay.get_hash_key("weapon_switchblade")] = {"SWITCHBLADE_VARMOD_BASE","SWITCHBLADE_VARMOD_VAR1","SWITCHBLADE_VARMOD_VAR2"},
        [gameplay.get_hash_key("weapon_knuckle")] = {"KNUCKLE_VARMOD_BASE","KNUCKLE_VARMOD_PIMP","KNUCKLE_VARMOD_BALLAS","KNUCKLE_VARMOD_DOLLAR","KNUCKLE_VARMOD_DIAMOND","KNUCKLE_VARMOD_HATE","KNUCKLE_VARMOD_LOVE","KNUCKLE_VARMOD_PLAYER","KNUCKLE_VARMOD_KING","KNUCKLE_VARMOD_VAGOS"},

        [gameplay.get_hash_key("weapon_combatshotgun")] = {"AT_AR_FLSH","AT_AR_SUPP"},
        [gameplay.get_hash_key("weapon_sawnoffshotgun")] = {"SAWNOFFSHOTGUN_VARMOD_LUXE"},
        [gameplay.get_hash_key("weapon_bullpupshotgun")] = {"AT_AR_FLSH","AT_AR_SUPP_02","AT_AR_AFGRIP"},
        [gameplay.get_hash_key("weapon_pumpshotgun")] = {"AT_AR_FLSH","AT_SR_SUPP","PUMPSHOTGUN_VARMOD_LOWRIDER"},
        [gameplay.get_hash_key("weapon_assaultshotgun")] = {"ASSAULTSHOTGUN_CLIP_01","ASSAULTSHOTGUN_CLIP_02","AT_AR_FLSH","AT_AR_SUPP","AT_AR_AFGRIP"},
        [gameplay.get_hash_key("weapon_heavyshotgun")] = {"HEAVYSHOTGUN_CLIP_01","HEAVYSHOTGUN_CLIP_02","HEAVYSHOTGUN_CLIP_03","AT_AR_FLSH","AT_AR_SUPP_02","AT_AR_AFGRIP"},
        [gameplay.get_hash_key("weapon_pumpshotgun_mk2")] = {"PUMPSHOTGUN_MK2_CLIP_01","PUMPSHOTGUN_MK2_CLIP_INCENDIARY","PUMPSHOTGUN_MK2_CLIP_ARMORPIERCING","PUMPSHOTGUN_MK2_CLIP_HOLLOWPOINT","PUMPSHOTGUN_MK2_CLIP_EXPLOSIVE","AT_SIGHTS","AT_SCOPE_MACRO_MK2","AT_SCOPE_SMALL_MK2","AT_AR_FLSH","AT_SR_SUPP_03","AT_MUZZLE_08"},

        [gameplay.get_hash_key("weapon_emplauncher")] = {"EMPLAUNCHER_CLIP_01"},
        [gameplay.get_hash_key("weapon_grenadelauncher")] = {"GRENADELAUNCHER_CLIP_01","AT_AR_FLSH","AT_AR_AFGRIP","AT_SCOPE_SMALL"},
        [gameplay.get_hash_key("weapon_grenadelauncher_smoke")] = {"GRENADELAUNCHER_CLIP_01","AT_AR_FLSH","AT_AR_AFGRIP","AT_SCOPE_SMALL"}
    }

-- Functions
    local function mp_stat(...)
        local Type <const>, Stat, Value <const> = ...
        Stat = gameplay.get_hash_key("MP"..stats.stat_get_int(gameplay.get_hash_key("MPPLY_LAST_MP_CHAR"), 1).."_"..Stat)
        if Value ~= nil then
            if Type == "Int" then
                stats.stat_set_int(Stat, Value, true)
            elseif Type == "Bool" then
                stats.stat_set_bool(Stat, (Value == 1 or Value == "true" or Value == true), true)
            end
        else
            return (Type == "Int" and stats.stat_get_int(Stat, 1) or (stats.stat_get_bool(Stat, 0) and 1 or 0))
        end
    end

    local function update_editor(...)
        local Ped <const>, Type <const>, Apply <const> = o.get_ped(o.pid()), ...
        if Type == "Stat" then
            local Stat <const> = Stat[o.stat_type.value]
            if Apply then
                mp_stat(Stat["Type"], Stat["Name"], o.stat_value.value)
            end
            o.stat_value:set_str_data(Stat["Data"])
            o.stat_value.value = mp_stat(Stat["Type"], Stat["Name"])
        elseif Type == "Comp" then
            local Max = ped.get_number_of_ped_drawable_variations(Ped, o.comp_type.value)
            o.comp_variation.value, o.comp_variation.max = (Apply and o.comp_variation.value or o.get_comp_variation(Ped, o.comp_type.value)), (Max < 1 and 0 or Max - 1)
            Max = ped.get_number_of_ped_texture_variations(Ped, o.comp_type.value, o.comp_variation.value)
            o.comp_texture.max = (Max < 1 and 0 or Max - 1)
            if Apply then
                ped.set_ped_component_variation(Ped, o.comp_type.value, o.comp_variation.value, o.comp_texture.value, 0)
            end
            o.comp_texture.value, o.comp_texture.hidden, o.comp_blank.hidden = o.get_comp_texture(Ped, o.comp_type.value), (o.comp_texture.max < 1), (o.comp_texture.max > 0)
        elseif Type == "Prop" then
            local Var <const>, Max = o.get_prop_variation(Ped, o.prop_type.value), ped.get_number_of_ped_prop_drawable_variations(Ped, o.prop_type.value)
            o.prop_variation.value, o.prop_variation.max = (Apply and o.prop_variation.value or Var == 4294967295 and 0 or Var), (Max < 1 and 0 or Max - 1)
            Max = o.get_max_prop_textures(Ped, o.prop_type.value, o.prop_variation.value)
            o.prop_texture.max = (Max < 1 and 0 or Max - 1)
            if Apply then
                ped.set_ped_prop_index(Ped, o.prop_type.value, o.prop_variation.value, o.prop_texture.value, 0)
                if o.prop_type.value == 0 and o.config["keep_helmets"].on then
                    ped.set_ped_config_flag(Ped, 36, 1)
                end
            end
            o.prop_texture.hidden, o.prop_blank.hidden = (o.prop_texture.max < 1), (o.prop_texture.max > 0)
        end
    end

    local function is_freemode_model(...)
        local Hash <const> = ...
        return (Hash == gameplay.get_hash_key("mp_m_freemode_01") and "Male" or Hash == gameplay.get_hash_key("mp_f_freemode_01") and "Female") or false
    end

    local function set_outfit(...)
        local Ped, Table <const> = o.get_ped(o.pid()), ...
        local Model <const> = Table["MODEL"] and Table["MODEL"][0] or o.get_model(o.pid())
        if o.respawn or Model ~= o.get_model(o.pid()) then
            local Health <const>, Equip <const>, Table <const> = ped.get_ped_max_health(Ped), (not player.is_player_in_any_vehicle(o.pid()) and ped.get_current_ped_weapon(Ped) or 0), {}
            for _, Weap in pairs(weapon.get_all_weapon_hashes()) do
                if weapon.has_ped_got_weapon(Ped, Weap) then
                    Table[Weap] = {weapon.get_ped_weapon_tint_index(Ped, Weap)}
                    for _, Comp in pairs(Attachment[Weap] or {}) do
                        if weapon.has_ped_got_weapon_component(Ped, Weap, gameplay.get_hash_key("COMPONENT_"..Comp)) then
                            Table[Weap][#Table[Weap] + 1] = gameplay.get_hash_key("COMPONENT_"..Comp)
                        end
                    end
                end
            end
            while entity.is_entity_dead(Ped) do
                system.yield(0)
            end
            if Model == o.get_model(o.pid()) then
                goto Skip
            end
            local Timer <const> = utils.time_ms() + 800
            while not streaming.has_model_loaded(Model) and utils.time_ms() < Timer do
                streaming.request_model(Model)
                system.yield(0)
            end
            player.set_player_model(Model)
            system.yield(0)
            streaming.set_model_as_no_longer_needed(Model)
            Ped = o.get_ped(o.pid())
            ped.set_ped_max_health(Ped, Health)
            ped.set_ped_health(Ped, Health)
            for Weap, Table in pairs(Table) do
                weapon.give_delayed_weapon_to_ped(Ped, Weap, 0, false)
                for i = 2, #Table do
                    weapon.give_weapon_component_to_ped(Ped, Weap, Table[i])
                end
                weapon.give_delayed_weapon_to_ped(Ped, Weap, 0, Weap == Equip)
                weapon.set_ped_weapon_tint_index(Ped, Weap, Table[1])
                weapon.set_ped_ammo(Ped, Weap, 9999)
            end
        end
        for i, Var in pairs(Table["COMPONENTS"] or {}) do
            local Tex <const> = Table["COMPONENTS_TEXTURES"] and Table["COMPONENTS_TEXTURES"][i] or 0
            ped.set_ped_component_variation(Ped, i, Var, Tex or 0, 0)
        end
        ped.clear_all_ped_props(Ped)
        if Table["PROPERTIES"] then
            for i = 0, 7 do
                local Var <const>, Tex <const> = Table["PROPERTIES"][i], Table["PROPERTIES_TEXTURES"] and Table["PROPERTIES_TEXTURES"][i] or 0
                if Var and Var > -1 then
                    local Max <const> = o.get_max_prop_textures(Ped, i, Var)
                    ped.set_ped_prop_index(Ped, i, Var, ((Tex < 0 or Tex > (Max > 0 and Max - 1 or 0)) and 0 or Tex) or 0, 0)
                    if i == 0 and o.config["keep_helmets"].on then
                        ped.set_ped_config_flag(Ped, 36, 1)
                    end
                end
            end
        end
        for i, value in pairs(Table["STATS"] or {}) do
            mp_stat(Stat[i]["Type"], Stat[i]["Name"], value)
        end
        if is_freemode_model(Model) then
            if Table["HEAD_BLEND"] then
                ped.set_ped_head_blend_data(Ped, Table["HEAD_BLEND"][3] or 0, Table["HEAD_BLEND"][4] or 0, Table["HEAD_BLEND"][5] or 0, Table["HEAD_BLEND"][6] or 0, Table["HEAD_BLEND"][7] or 0, Table["HEAD_BLEND"][8] or 0, Table["HEAD_BLEND"][9] or 0.0, Table["HEAD_BLEND"][10] or 0.0, Table["HEAD_BLEND"][11] or 0.0)
                ped.set_ped_hair_colors(Ped, Table["HEAD_BLEND"][1] or 0, Table["HEAD_BLEND"][2] or 0)
                ped.set_ped_eye_color(Ped, Table["HEAD_BLEND"][0] or 0)
                for i, Value in pairs(Table["FACE_FEATURES"] or {}) do
                    ped.set_ped_face_feature(Ped, i, Value or 0.0)
                end
                if Table["HEAD_OVERLAYS"] then
                    for i = 0, 12 do
                        ped.set_ped_head_overlay(Ped, i, Table["HEAD_OVERLAYS"][i] or i, Table["HEAD_OVERLAYS"][i + 26] or 0.0)
                        ped.set_ped_head_overlay_color(Ped, i, Table["HEAD_OVERLAYS"][i + 39] or -1, Table["HEAD_OVERLAYS"][i + 13] or -1, Table["HEAD_OVERLAYS"][i + 52] or -1)
                    end
                end
            end
        end
        ::Skip::
        o.respawn = false
        ped.clear_ped_blood_damage(Ped)
    end

    local function get_input(...)
        local Default, Type <const>, Path <const> = ...
        if Path or o.config["confirmation"].on then
            local Title = (Path and "Enter The Name Of Your New "..Type or Type)
            repeat
                local Status <const>, Text <const> = input.get(Title, Default, 165, 0)
                if Status == 0 then
                    if Path then
                        Default = Text
                        if Text:find("^%s*$") then
                            Title, Default = Type.." Name Can't Be Blank", ""
                        elseif Text:find("[<>:\"/\\|%?%*]") or (Type == "Folder" and Text:find("[.]")) then
                            Title = "Can't Use Invalid Characters"
                        elseif (Type == "Outfit" and utils.file_exists(Path.."\\"..Text..".ini") or Type == "Folder" and utils.dir_exists(Path.."\\"..Text)) then
                            Title = Type.." With That Name Already Exists"
                        elseif Text then
                            if Type == "Folder" then
                                utils.make_dir(Path.."\\"..Text)
                                break
                            else
                                return Path.."\\"..Text..".ini"
                            end
                        end
                    else
                        return true
                    end
                end
                system.yield(0)
            until Status == 2
        else
            return true
        end
    end

    local function manage_file(...)
        local Action <const>, Path <const>, Table <const> = ...
        if Action == "Write" then
            local File <const>, Config <const> = io.open(Path, "w+"), not Table and o.config
            for i = 1, #o.all_sections do
                if Config or Table[o.all_sections[i]] and next(Table[o.all_sections[i]]) then
                    File:write("["..(Config and "Saved Config" or o.all_sections[i]).."]\n")
                    for Key, Value in pairs(Config or Table[o.all_sections[i]]) do
                        File:write((Config and Key..":" or "index"..Key.."=")..tostring(Config and (Value.type == 1058 and Value.value or (Value.on and 1 or 0)) or Value == 4294967295 and -1 or Value).."\n")
                    end
                    if Config then
                        menu.notify("Config File Saved.", "Outfitter.lua", 2, 0xff00ff00)
                        break
                    end
                end
            end
            File:flush()
            File:close()
        elseif utils.file_exists(Path) then
            local Table <const>, Section = {}
            for Line in io.lines(Path) do
                local NewSection <const> = Line:match("^%[(.+)%]$")
                if NewSection then
                    Section, Table[NewSection] = NewSection, {}
                else
                    local Key <const>, Value <const> = Line:match("^(.+)[:=](.+)$")
                    if Key and Value then
                        if Section ~= "Saved Config" then
                            Table[Section][tonumber(Key:match("%d+"))] = tonumber(Value) or Value == "true"
                        elseif o.config[Key].type == 1058 then
                            o.config[Key].value = tonumber(Value)
                        else
                            o.config[Key].on = Value == "1"
                        end
                    end
                end
            end
            return Table
        end
    end

    local function get_outfit(...)
        local Pid <const>, Sections <const>, Path = ...
        local Ped <const>, Model <const>, Table <const> = o.get_ped(Pid), o.get_model(Pid), {}
        for i = 1, #Sections do
            Table[Sections[i]] = {}
        end
        if Table["COMPONENTS"] and Table["COMPONENTS_TEXTURES"] then
            for i = 0, 11 do
                Table["COMPONENTS"][i], Table["COMPONENTS_TEXTURES"][i] = o.get_comp_variation(Ped, i), o.get_comp_texture(Ped, i)
            end
        end
        if Table["PROPERTIES"] and Table["PROPERTIES_TEXTURES"] then
            for i = 0, 7 do
                if i < 3 or i > 5 then
                    Table["PROPERTIES"][i], Table["PROPERTIES_TEXTURES"][i] = o.get_prop_variation(Ped, i), o.get_prop_texture(Ped, i)
                end
            end
        end
        if Table["STATS"] then
            for i = 0, #Stat do
                Table["STATS"][i] = mp_stat(Stat[i]["Type"], Stat[i]["Name"])
            end
        end
        if Table["MODEL"] then
            Table["MODEL"][0] = Model
        end
        if is_freemode_model(Model) then
            if Table["HEAD_BLEND"] then
                Table["HEAD_BLEND"][0], Table["HEAD_BLEND"][1], Table["HEAD_BLEND"][2] = ped.get_ped_eye_color(Ped) or 0, ped.get_ped_hair_color(Ped) or 0, ped.get_ped_hair_highlight_color(Ped) or 0
                local Data <const>, Name <const> = ped.get_ped_head_blend_data(Ped) or {}, {"shape_first","shape_second","shape_third","skin_first","skin_second","skin_third","mix_shape","mix_skin","mix_third"}
                for i = 1, #Name do
                    Table["HEAD_BLEND"][i + 2] = Data[Name[i]] or 0
                end
            end
            if Table["FACE_FEATURES"] then
                for i = 0, 19 do
                    Table["FACE_FEATURES"][i] = ped.get_ped_face_feature(Ped, i) or 0.0
                end
            end
            if Table["HEAD_OVERLAYS"] then
                for i = 0, 12 do
                    Table["HEAD_OVERLAYS"][i] = ped.get_ped_head_overlay_value(Ped, i) or -1
                    Table["HEAD_OVERLAYS"][i + 13] = ped.get_ped_head_overlay_color(Ped, i) or -1
                    Table["HEAD_OVERLAYS"][i + 26] = ped.get_ped_head_overlay_opacity(Ped, i) or 0.0
                    Table["HEAD_OVERLAYS"][i + 39] = ped.get_ped_head_overlay_color_type(Ped, i) or -1
                    Table["HEAD_OVERLAYS"][i + 52] = ped.get_ped_head_overlay_highlight_color(Ped, i) or -1
                end
            end
        end
        if Path then
            Path = get_input(Pid ~= o.pid() and player.get_player_name(Pid) or "", "Outfit", Path)
            if Path then
                manage_file("Write", Path, Table)
            end
        else
            return Table
        end
    end

    local function load_features(...)
        local Style <const>, Children <const>, Parents = o.config["folder_style"].value, o.outfitter_lua.children, ...
        for i = 5, #Children do
            if Children[i].type == 2048 then
                for i, Child in pairs(Children[i].children) do
                    if not Parents or i > 1 then
                        o.delete_feature(Child.id)
                    end
                end
            end
            if not Parents then
                o.delete_feature(Children[i].id)
            end
        end
        o.save_feat.data, o.folder_feat.hidden, o.save_feat.name, o.folders = Style, Style ~= 1, (Style == 2 and "Create New Folder" or "Save Current Outfit"), {"No Folder"}
        for i, Name in pairs(utils.get_all_sub_directories_in_directory(o.directory)) do
            o.folders[i + 1] = Name
        end
        menu.get_player_feature(o.player_feat):set_str_data(o.folders)
        o.folders[1], Parents = (Style == 1 and "Create New Folder" or "Files Not In A Folder"), (Parents or {})
        o.folder_feat:set_str_data(o.folders)
        for i = 1, #o.folders do
            local Path = o.directory..(Style == 1 and (o.folder_feat.value ~= 0 and "\\"..o.folders[o.folder_feat.value + 1] or "") or i == 1 and "" or "\\"..o.folders[i])
            if Style == 2 and not Parents[i] then
                Parents[i] = o.add_feature(o.folders[i], "parent", o.outfitter_lua.id, function()
                    o.refresh = false
                end)
                o.add_feature("Save Current Outfit", "action", Parents[i].id, function(f)
                    get_outfit(o.pid(), o.all_sections, Path)
                    load_features(Parents)
                end)
            end
            for _, Name in pairs(utils.get_all_files_in_directory(Path, "ini")) do
                o.add_feature(Name:gsub("%.ini$", ""), "action_value_str", (Parents[i] or o.outfitter_lua).id, function(f)
                    local Exists <const> = utils.file_exists(Path.."\\"..Name)
                    if not Exists or f.value == 3 and get_input("Permanently Delete File From System, Confirm?", "Delete "..Name) then
                        if Exists then
                            io.remove(Path.."\\"..Name)
                            menu.notify("Deleted "..Name, "Outfitter.lua", 2, 0xff00ff00)
                        else
                            menu.notify("File doesn't exist.", "Outfitter.lua", 2, 0xff0000ff)
                        end
                        o.delete_feature(f.id)
                    elseif f.value ~= 3 then
                        local Table <const> = manage_file("Parse", Path.."\\"..Name)
                        if f.value == 0 then
                            set_outfit(Table)
                        elseif f.value == 1 and get_input("Update File To Use Current Headblend, Confirm?", "Edit "..Name) or f.value == 2 and get_input("Update File To Not Apply Headblend, Confirm?", "Edit "..Name) then
                            for _, Section in pairs({"HEAD_OVERLAYS","HEAD_BLEND","FACE_FEATURES"}) do
                                Table[Section] = f.value == 1 and get_outfit(o.pid(), {Section})[Section]
                            end
                            manage_file("Write", Path.."\\"..Name, Table)
                            menu.notify("Edited "..Name, "Outfitter.lua", 2, 0xff00ff00)
                        end
                    end
                end):set_str_data({"Apply","Overwrite Blend","Remove Blend","Delete File"})
            end
            if i == 1 and Style ~= 0 then
                if Style == 2 then
                    Parents[1].hidden = Parents[1].child_count < 2
                else
                    break
                end
            end
        end
    end

-- Parents
    o.outfitter_lua = o.add_feature("Outfitter.lua", "parent", 0, function()
        if o.refresh then
            load_features()
        end
        o.refresh = true
    end)

    o.outfit_editor = o.add_feature("Outfit Editor", "parent", o.outfitter_lua.id, function()
        update_editor("Stat")
        update_editor("Comp")
        update_editor("Prop")
    end)

    o.script_settings = o.add_feature("Script Settings", "parent", o.outfitter_lua.id)

-- Outfit Editor
    -- Stat
        o.stat_type = o.add_feature("Stat", "autoaction_value_str", o.outfit_editor.id, function()
            update_editor("Stat")
        end)
        o.stat_type:set_str_data({"Helmet Visor","Parachute Bag","Parachute Chute","Illuminated Clothing"})

        o.stat_value = o.add_feature("Value", "autoaction_value_str", o.outfit_editor.id, function()
            update_editor("Stat", true)
        end)

        if not menu.is_trusted_mode_enabled() then
            menu.notify("Enable trusted mode for stats to work.", "Outfitter.lua", 10, 0xff00a2ff)
            o.stat_type.hidden, o.stat_value.hidden = true, true
        end

    -- Component
        o.add_feature("Clear Clothing", "action", o.outfit_editor.id, function()
            local Ped <const>, Model <const> = o.get_ped(o.pid()), is_freemode_model(o.get_model(o.pid()))
            for i = 0, 11 do
                if not Model or i ~= 0 and i ~= 2 then
                    ped.set_ped_component_variation(Ped, i, ((i == 8 and Model) and 15 or 0), 0, 0)
                end
            end
            update_editor("Comp")
        end)

        o.comp_type = o.add_feature("Component", "autoaction_value_str", o.outfit_editor.id, function()
            update_editor("Comp")
        end)
        o.comp_type:set_str_data({"Head","Mask","Hair","Gloves","Legs","Parachute","Feet","Accessory","Torso2","Vest","Decal","Torso"})

        o.comp_variation = o.add_feature("Variation", "autoaction_value_i", o.outfit_editor.id, function()
            update_editor("Comp", true)
        end)
        o.comp_variation.min = 0

        o.comp_texture = o.add_feature("Texture", "autoaction_value_i", o.outfit_editor.id, function()
            update_editor("Comp", true)
        end)
        o.comp_texture.min = 0

        o.comp_blank = o.add_feature("Texture", "action", o.outfit_editor.id, function()
            menu.notify("No other textures available.", "Outfitter.lua", 2, nil)
        end)

    -- Property
        o.add_feature("Clear Props", "action", o.outfit_editor.id, function()
            ped.clear_all_ped_props(o.get_ped(o.pid()))
            o.prop_texture.value = 0
            update_editor("Prop")
        end)

        o.prop_type = o.add_feature("Property", "autoaction_value_str", o.outfit_editor.id, function(f)
            f.value = (f.value == 3 and 6 or f.value == 5 and 2 or f.value)
            update_editor("Prop")
        end)
        o.prop_type:set_str_data({"Hat","Glasses","Ears","3","4","5","L Wrist","R Wrist"})

        o.prop_variation = o.add_feature("Variation", "autoaction_value_i", o.outfit_editor.id, function()
            update_editor("Prop", true)
            if o.prop_type.value == 0 and o.stat_type.value == 0 then
                update_editor("Stat")
            end
        end)
        o.prop_variation.min = 0

        o.prop_texture = o.add_feature("Texture", "autoaction_value_i", o.outfit_editor.id, function()
            update_editor("Prop", true)
        end)
        o.prop_texture.min = 0

        o.prop_blank = o.add_feature("Texture", "action", o.outfit_editor.id, function()
            menu.notify("No other textures available.", "Outfitter.lua", 2, nil)
        end)

-- Script Settings
    o.add_feature("Save Config", "action", o.script_settings.id, function()
        manage_file("Write", o.directory.."\\Settings.cfg")
    end)

    o.config["folder_style"] = o.add_feature("Folder Style:", "autoaction_value_str", o.script_settings.id)
    o.config["folder_style"]:set_str_data({"Disabled","Cycle","List"})

    o.add_feature("Freeze Current Outfit", "toggle", o.script_settings.id, function(f)
        local Table <const>, Cleared = get_outfit(o.pid(), {"COMPONENTS","COMPONENTS_TEXTURES","PROPERTIES","PROPERTIES_TEXTURES","MODEL"})
        while f.on and (Table["MODEL"][0] == o.get_model(o.pid())) do
            local Ped <const> = o.get_ped(o.pid())
            for i = 0, 11 do
                local Var <const>, Tex <const> = Table["COMPONENTS"][i], Table["COMPONENTS_TEXTURES"][i]
                if (i ~= 5 or (Var > 39 and Var < 48 or Var > 80 and Var < 89)) and (Var ~= o.get_comp_variation(Ped, i) or Tex ~= o.get_comp_texture(Ped, i)) then
                    ped.set_ped_component_variation(Ped, i, Var, Tex, 0)
                    update_editor("Comp")
                end
            end
            for i = 0, 7 do
                local Var <const>, Tex <const> = Table["PROPERTIES"][i], Table["PROPERTIES_TEXTURES"][i]
                if (i < 3 or i > 5) and Var ~= o.get_prop_variation(Ped, i) then
                    if Cleared then
                        local Max <const> = o.get_max_prop_textures(Ped, i, Var)
                        ped.set_ped_prop_index(Ped, i, Var, (Tex > (Max < 1 and 0 or Max -1) or Tex < 0) and 0 or Tex, 0)
                        update_editor("Prop")
                        if i == 0 and o.config["keep_helmets"].on then
                            ped.set_ped_config_flag(Ped, 36, 1)
                        end
                    else
                        ped.clear_all_ped_props(Ped)
                        Cleared = true
                        goto Skip
                    end
                end
            end
            Cleared = false
            ::Skip::
            repeat
                system.yield(0)
            until not o.respawn
        end
        f.on = false
    end)

    o.config["confirmation"] = o.add_feature("Confirmation To Edit Or Delete Files", "toggle", o.script_settings.id)

    o.config["keep_helmets"] = o.add_feature("Prevent Character Removing Helmet", "toggle", o.script_settings.id, function(f)
        ped.set_ped_config_flag(o.get_ped(o.pid()), 36, f.on and 1 or 0)
    end)

    o.config["car_headgear"] = o.add_feature("Prevent Vehicles Removing Headgear", "toggle", o.script_settings.id, function(f)
        while f.on do
            system.yield(0)
            local Ped <const> = o.get_ped(o.pid())
            local hat_var <const>, hat_tex <const>, top_var <const>, top_tex <const> = o.get_prop_variation(Ped, 0), o.get_prop_texture(Ped, 0), o.get_comp_variation(Ped, 11), o.get_comp_texture(Ped, 11)
            while f.on and o.get_prop_variation(Ped, 0) == hat_var and o.get_prop_texture(Ped, 0) == hat_tex and o.get_comp_variation(Ped, 11) == top_var and o.get_comp_texture(Ped, 11) == top_tex do
                system.yield(0)
                if player.is_player_in_any_vehicle(o.pid()) and (o.get_prop_variation(Ped, 0) ~= hat_var or o.get_comp_variation(Ped, 11) ~= top_var) then
                    ped.set_ped_component_variation(Ped, 11, top_var, top_tex, 0)
                    ped.set_ped_prop_index(Ped, 0, hat_var, hat_tex, 0)
                end
            end
        end
    end)

    o.config["model_resets"] = o.add_feature("Prevent Model Resetting After Respawn", "toggle", o.script_settings.id, function(f)
        while f.on do
            system.yield(0)
            if entity.is_entity_dead(o.get_ped(o.pid())) then
                o.respawn = true
                set_outfit(get_outfit(o.pid(), o.all_sections))
            end
        end
    end)

    manage_file("Parse", o.directory.."\\Settings.cfg")

-- Outfit Saving
    o.folder_feat = o.add_feature("Current Folder:", "autoaction_value_str", o.outfitter_lua.id, function(f)
        if f.value == 0 and f.value == f.data then
            get_input("", "Folder", o.directory)
        end
        load_features()
        f.data = f.value
    end)

    o.save_feat = o.add_feature("", "action", o.outfitter_lua.id, function(f)
        if f.data == 2 then
            get_input("", "Folder", o.directory)
        else
            get_outfit(o.pid(), o.all_sections, o.directory..(f.data == 1 and (o.folder_feat.value ~= 0 and "\\"..o.folders[o.folder_feat.value + 1] or "") or ""))
        end
        load_features()
    end)

    o.player_feat = menu.add_player_feature("Save Character:", "action_value_str", 0, function(f, pid)
        get_outfit(pid, o.all_sections, o.directory..(f.value ~= 0 and "\\"..o.folders[f.value + 1] or ""))
        load_features()
    end).id

    load_features()