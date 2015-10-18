> Intro.

Since Xash3D/Sing is Half-Life compliant engine, then all the above innovations will be given in relation
to
engine GoldSrc, both advantages Xash3D/Sing.


---


> Basis limits.

Unlike GoldSource basis limits in Xash3D ,no only more biggest,but and more customizable. For example, gameinfo.txt .
MAX\_EDICTS 600 - 4096 (vs 900 in GoldSource).
MAX\_TEMPENTS 300 - 2048 (vs 500 in GoldSource).
MAX\_PARTICLES 1024 - 8192 (vs 4096 in GoldSource).
MAX\_BEAMS 64 - 512 (vs 64 in GoldSource)
Manually reduce limits, help you save memory in those mods,where don't need many edicts.
Also, parameter MAX\_EDICTS send from server if game is local, it automatically adjust client for new enviroment.

> Other limits.

This limits protect in engine, client can't change it.

MAX\_VISIBLE\_PACKET 512 - entityes (256 in GoldSource).
MAX\_MODELS 2048 unique models (include sprites and bmodels)
MAX\_SOUNDS 2048
MAX\_SENTENCES 2048 (1534 in GoldSource)
MAX\_USER\_MESSAGES 191 (128 in WON GoldSource)
MAX\_TEXTURES 4096 (form them 2048 may be used by VGUI)
MAX\_MESSAGES 2048 (1024 in GoldSource) (count of messages in titles.txt)
Maximal sizes for indexed textures: 1024х1024 (vs 512х512 in GoldSource)
Maximal sizes for truecolor textures: 4096x4096.ent.


> Limits for bsp-models.

MAX\_MAP\_MODELS 1024 (256 in GoldSource)
MAX\_MAP\_LEAFS 32767 (8192 in GoldSource)
Note:Other limits for bsp-models configured by compilator ,and anyhow no depend on engine


> Studiomodels scale.
In mod Spirit Of Half-Life has been added interesting possibility control for visible size anythink Studiomode,
like sprites, through variable scale. This possibility did not affect for physical box ofmodel.
Xash3D have possibility take this.Enable studiomodel scale do from console cvar
"sv\_allow\_studio\_scaling" "1".This variable save its value inconfig.cfg,
and also available over the network to all the players in a multiplayer game.

> Get attachment angles on server side.

As is well known engine function GET\_ATTACHMENT, dont return angles for attachment (this possibility just is no
> how in engine, and in model compiler). Xash3D can partially correct this,return as angles,
dirrect from bone to attachment, which is considered vector forward,and fully compared with the vector,
which you can see in half-Life Model Viewer (any version), if you enable function "Show attachment".
This possibility may be useful for realise such things, how headcrab, jump off a dead zombie,
realistic position laser sight on viewmodel.
In default,enabled from console cvar "sv\_allow\_studio\_attachment\_angles" "1".
This variable save its value in config.cfg, but does not affect the client.

> Realistic values of lighting on server side.

Xash3D return more actual lighting values, because the takes a value light-styles
and their current value. In future versions, also planned to provide a count of the brightness of an different entityes
for flashlights and other players (example in multyplayer). And player lighting takes immediately from render
and take and value all light types, include entity light and dynamic light.


> Can save camera (trigger\_camera)

How we know , in Half-Life camera dont restore int save/load, this may be interfere with a player to
show script scene,and author of mod.In Xash3D this successfully fixed.
Now anythink camera in anythink mod will be restored in load game from save.

> Better Decal save

In Half-Life decal save do only for world brushes and random on entities - on doors,elevators
and other moves entities.In Xash3D decals successfuly save on all brushes and entities.
Also we makes transition decals between levels (have in Half-Life, but in dont work state).


> Entity patch technology support.

This technology allow load entities for selected map from out script with expansion ".ent".
This script may be done by  ripent.exe, and by engine functions, example: console variable entpatch 

<map\_name>

. If command entpatch input when map loaded,
then it will automatically create entity patch for this map.


> Support other map types.

Xash3D support this BSP map types : Quake 1, Half-Life, Half-Life Blue Shift.In addition, there
supports other bmodel format, example: Quake1 (health kit models,ammo models).
Note:Map from Quake1 better to use in deathmatch classic mod, to prevent sticking Player
because hull size is different, for Half-Life and Quake. Also,in DMC have full set of entities,that
required for full deathmatch on these maps.

> Support precaching "on the fly"

Xash3D may precaching resources "on the fly", in game, this avoids annoying error
PF\_PRECACHE\_ERROR.Also Xash3D dont crashing with error, if model or sound not found.

> Secure transmission of user's messages to the client.

Xash3D dont crashing with error,if user message exceeded the amount stated in the registration,
either did not exist is declared. This message just not send,and console take
a message.Also SVC\_TEMPENTITY is completely safe message, how user's messages.

> Safety changelevel.

Before load new map, Xash3D analyzing her status (not unload current) and set select,
Is it possible to normal changelevel.In the case of any error on the next map, in console will be sent message, and next map not load.Except for the error will be present recommendation
to fix this error, which will undoubtedly make life easier for mappers, since the error level changes, is usually the most obscure and most difficult. In some cases Xash3D by himself disable smoothchangelevel
and activate default changlevel,like Quake.Corresponding error message will also be displayed in the console.

> Included titles

Engine function pfnEndSection feeding into it keyword "oem\_end\_credits" displayed titles at screen, and on completion calls the end of the game.
The titles code have in menu.dll and may be changed by user.


> Recursive search of an entity visible

Xash3D support recursive search visible entities on server, when you add them to the visible-list for client.
An example of implementation of such a search can be found in the SDK,in function SetupVisibility and AddToFullPack (client.cpp).


> Most stability MOVETYPE\_PUSH

In Xash3D objects in moves platforms behave in a more stable and do not move out at sharp bends.


> New type of physic: MOVETYPE\_COMPOUND

Allow "to glue" one entity to the two entity, with angles and if ojects moves.Example in SDK - crossbow bolt, which correctly attachments to func\_pushable, func\_rotating, func\_tracktrain and other brush models.

> Time stop

Engine has possibility to stop time, from console "playersonly".This command hold time on server and on client,except the player.
This can be useful for taking screenshots, or to verify the behavior of physics at the stability and other
debug functions.

> "Transparency" file system.

Xash3D fully ignore string "wad" in map , and not crashing,if one on more wads not found.
In GoldSrc the situation was complicated by the fact, what engine required wads, dont verify, Do I need this map
any of these textures. Ie was uncommon situation, when Half-Life require any wad, for this map
just "random", Although he told her absolutely not required.Also has been added load textures
from wads with help pfnLoadFileForMe on server, and COM\_LoadFile on client.
Just type the name of the textures in wad-file and the engine finds it from itself. You also may be type wishful
wad in path, if want load texture from this file. Example: "gfx.wad/conback".

> Autocomplete in console.

Xash3D has a powerful system of autocompletion console commands, that allows you to display not only their listings,
but and short description.For added convenience, you can type in console
makehelp,and engine automatically generated help.txt,with list all console commands and variables,and also it's
short description. Also support autocomplete for map name, video-file, background track, script files
.cfg,  save name, weapon name (for command give), for testing sounds (command play) and for change game
directory (mod directory).

> Engine with not attach for base directory.

How all known, majority count of Quake-engines full attach for parrent's folder with your name,this dont have value for mods,but very ungly, if you want make a total conversion of game, and replace parent's folder. Xash3D don't have parrent's folder,we can change her with launcher - small exe-file, her is defined there.So, you can make a game, don't like Half-life.

> full usefull console of dedicated-server

For console of dedicated server works autocomplete in full work state,also support saves history
> of entered command at current session.

> Colored consol messages

Xash3D system colored perfixes of consol messages,this born in Quake3.
This system allow to enter perfix - ^ with number 0 to 7, number value - value of color: 0 - black, 1 - red, 2 - green, 3 - yellow, 4 - blue, 5 - aqua, 6 - purple, 7 - white.
This table fully compotable with Quake3 and works how analog - string will be colored full.Cancel color you can with command ^7. This system works and in menu,also can color players nick-names.
Note: Allow this system for VGUI enable with colnsole variable "vgui\_colorstrings" "1"

> Auto-levelshots system.

Engine support the system of personal levelshots for all levels.For enable this, type in consol
"allow\_levelshots" "1". All screenshots Xash3D will be maked automatically, but You of course, can repace it for your screen shots.

> background map support

Background maps, this maps replace background image in menu.This system you can see in  Half-Life 2.
Xash3D bette easy system - map select load random map from list-file.
File with map list will be named "chapterbackgrounds.txt" and put in scripts folder (if you don't have this folder - just create it). Name next background map, starts in new line.
Example:

с1a1a
c2a1
c4a3
c2a5
c0a0

For background map you can use all game map, but don't use map, where player drive in monorail train,this may be see ugly.

> Sprite interpolation.

Enable default.This make sprite animation better smooth, for sprites with rendermode texture and additive.
Enable\disable this effect , with console variable "r\_sprite\_lerping".
Note: For right work sprite interpolation server sprite framerate will be 10 FPS
(don't pev->framerate). This parameter defined in think
with nextthink in 0.1 sec and don't change in mods.

> Lightstyle interpolation

Enable default.Don't react for short sequences,like enable and disable light.
Very good smooth light animation on long and slow sequences,type SlowStrobe or SlowPulse.
Note: this option may hard cut FPS.

> Support quake light textures luma (Quake-style)

This textures you can see on original maps in quake, how light states on texture.
This trick fully direfine in pallete in Quake, engine activate this function,for fully analog pallete from Quake or Quake2. This pallete very good
saves with just convert textures from wad2 in wad3, you can see it, fro example, on map
qstyle by Scrama.

> Better sprite and models lighting

Better models lighting add bone-to-bone lighting of static and dynamic light,
also right models lighting on all steps run too long sequences,when models
goes far enough away from its real position. Example: forklift.mdl
Lighting for sprites is right lighting all sprites,who compile as
type "alphtest" and the game has not been appointed rendermode additive. For example take a splash of blood around
lighting and glow in the dark.
And for models light take from no only world, but and from brush model.
note: if better lighting give wrong result in something games, you can disable it, with help
> "r\_lighting\_extended" "0" console variable.

> Play-list for background's sounds

How all know,in Half-Life mp3 file names, who replace AudioCD-tacks hardcoded in engine and can't be changed.In Xash3D for this tracks automatically will be created play-list,where
you can write your track or write key word "blank" - if track not found.Play-list located in media
foldren with name audiocd.txt

> Support save-shots and demo-shots.

This is - small images,whom show game place of this save or demo start.You can see it in
menu.

> Support player model in menu.

For replace ugly bmp image,you can see 3d model in menu and see changes in realtime.

> Dynamic skybox change.

You can change skybox "on the fly" , use "sv\_skyname", for example CVAR\_SET\_STRING.
This save skybox in save file and will be restored in load.Also you can change skybox
from console, use "skyname".This command like conmmand "sv\_skyname", buy work only for local client
and, don't write in save file.

> Twink monsters on trains and elevators.

In Xash3D fully fixed annoying twinking monsters, located on the trains or elevators, when moves the elevators.
This fix works on all mods and nohow does not intersect with those corrected in something mods,
example: SoHL:Custom Build.

> A more efficient culling system.

Xash3D using better effective culling system,this allow up FPS and do r\_speeds more small.
Also, except team "r\_lockpvs", you can use command "r\_lockcull", to evaluate the effectiveness of
culling system. In addition, the engine maintains a system of so-called static-brushes, at which any bmodel, provided
that it has rendermode = normal, zero position and zero angles of rotation, automatically becomes part of
World and draw with world's polys, in overloaded detail maps,by
func\_wall gives a significant boost in performance (for example - map Dm-knot by Scrama). However, this system
can produce tangible z-fighting for some maps of the old sample, created in Worldcraft Editor or Valve Hammer
Editor, that use integer coordinates for the position of all objects on the map.In this case, the system
Static-Brush is recommended to disable using a console command "gl\_allow\_static" "0".

> View atlases loaded textures.

You can see loaded textures with help console command "r\_showtextures". With its different values
engine shows the different textures of. 1 - system textures, generated in engine.
2 - texture of hud and menu. 3 - textures, used in map. 4 - frames of all sprites.
5 - textures for all studiomodels. 6 - lightmaps. 7 - decals. 8 - textures, loaded from VGUI.
9 - texture fro skybox.

NOte: Some tabs may contain too many textures, to see them all. In this case try to
do screen resolution more high.

> Automatically sort transparent surfaces.

This method ensures,what all translucent surfaces will be drawn in the correct order,Removal of
Observer, it is not guaranteed in Half-Life.


P.S Sorry for my bad English :)

---


> The End

This list will be updated when new features got announced.