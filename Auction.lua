local cc, packs = CrowdControl, CrowdControl.Packs
local pack = ModUtil.Mod.Register( "Auction", packs.Hades, false )

pack.Effects = { }; pack.Actions = { }; pack.Triggers = { }
pack.Parametric = { Actions = { }, Triggers = { } }

do 

    -- =====================================================
    -- Triggers
    -- =====================================================
    function pack.Parametric.Triggers.DuplicateWeapon( weaponTrait )
		return function(...)
            local currentWeapon = GetEquippedWeapon()
            -- ModUtil.Hades.PrintStack("Current Weapon: "..currentWeapon)
            -- ModUtil.Hades.PrintStack("New Weapon: "..weaponTrait)
            if currentWeapon == weaponTrait then
                return false
            end 

			cc.InvokeEffect(...)
			return true
		end
	end

    
    -- =====================================================
    -- Actions
    -- =====================================================
    function WeaponSwap( weaponTrait )
        UnequipWeaponUpgrade()
        wait( 0.02 )-- Distribute workload
        EquipPlayerWeapon( weaponTrait )
        wait( 0.02 )-- Distribute workload
        EquipWeaponUpgrade( CurrentRun.Hero )
    end
    

    function pack.Parametric.Actions.WeaponSwap( weaponTrait )
        return function (...)
            WeaponSwap( weaponTrait )
            return true
        end
    end


end

-- =====================================================
-- Effects
-- =====================================================
pack.Effects.SwordSwap = cc.RigidEffect(cc.BindEffect(pack.Parametric.Triggers.DuplicateWeapon("SwordWeapon"), pack.Parametric.Actions.WeaponSwap(WeaponData.SwordWeapon)))
pack.Effects.SpearSwap = cc.RigidEffect(cc.BindEffect(pack.Parametric.Triggers.DuplicateWeapon("SpearWeapon"), pack.Parametric.Actions.WeaponSwap(WeaponData.SpearWeapon)))
pack.Effects.ShieldSwap = cc.RigidEffect(cc.BindEffect(pack.Parametric.Triggers.DuplicateWeapon("ShieldWeapon"), pack.Parametric.Actions.WeaponSwap(WeaponData.ShieldWeapon)))
pack.Effects.BowSwap = cc.RigidEffect(cc.BindEffect(pack.Parametric.Triggers.DuplicateWeapon("BowWeapon"), pack.Parametric.Actions.WeaponSwap(WeaponData.BowWeapon)))
pack.Effects.FistSwap = cc.RigidEffect(cc.BindEffect(pack.Parametric.Triggers.DuplicateWeapon("FistWeapon"), pack.Parametric.Actions.WeaponSwap(WeaponData.FistWeapon)))
pack.Effects.GunSwap = cc.RigidEffect(cc.BindEffect(pack.Parametric.Triggers.DuplicateWeapon("GunWeapon"), pack.Parametric.Actions.WeaponSwap(WeaponData.GunWeapon)))




-- put our effects into the centralised Effects table, under the "Hades.Auctions" path
ModUtil.Path.Set( "Auction", ModUtil.Table.Copy( pack.Effects ), cc.Effects )

-- ModUtil.Path.Wrap( "BeginOpeningCodex", 
-- 	function(baseFunc)		
-- 		-- if not CanOpenCodex() then
        
--             -- WeaponSwap( WeaponData.FistWeapon )
--         myfunc =  pack.Parametric.Actions.WeaponSwap(WeaponData.SwordWeapon)
--         myfunc()
--             -- BowSecondaryFocusedFireTrait
-- 		-- end
-- 		baseFunc()
-- 	end
-- )
