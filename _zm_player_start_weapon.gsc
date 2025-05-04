
/*
    _zm_player_start_weapon.gsc
    shid 5/5/25

    Add this using to your map:
    #using scripts\zm\_zm_player_start_weapon;

    Add this scriptparsetree to your zone:
    scriptparsetree,scripts/zm/_zm_player_start_weapon.gsc

    Change weapon defines below to their APE name (ie. ray_gun, ar_accurate etc).

    Eat a burger.
*/

#define STR_WEAPON_TAKEO          "thundergun"
#define STR_WEAPON_DEMPSEY        "ar_cqb"
#define STR_WEAPON_NIKOLAI        "lmg_light"
#define STR_WEAPON_RICHTOFEN      "ray_gun"

/* Do not edit from here (or do I guess idc dont break it) */

#using scripts\shared\callbacks_shared;
#using scripts\zm\_zm_weapons;

#namespace zm_player_start_weapon;

function autoexec _character_setup()
{
    callback::on_spawned(&_give_start_weapon);
}

function _give_start_weapon()
{
    self notify("single_thread_start_weapon");
    self endon("single_thread_start_weapon");
    self endon("disconnect");
    self endon("bled_out");
    
    self waittill("weapon_change_complete");
    
    n_idx = self.characterindex % 4;

    foreach(w_weapon in self GetWeaponsListPrimaries())
        self TakeWeapon(w_weapon);
    
    switch(n_idx)
    {
        // Dempsey
        case 0:     
            w_give = GetWeapon(STR_WEAPON_DEMPSEY);
            break;
            
        // Nikolai
        case 1:     
            w_give = GetWeapon(STR_WEAPON_NIKOLAI);
            break;

        // Richtofen
        case 2:     
            w_give = GetWeapon(STR_WEAPON_RICHTOFEN);
            break;

        // Takeo
        case 3:     
            w_give = GetWeapon(STR_WEAPON_TAKEO);
            break;
    }

    self zm_weapons::weapon_give(w_give);

    self SwitchToWeaponImmediate(w_give);
}
