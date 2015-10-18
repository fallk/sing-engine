Sing is Half-Life (binary)compatible engine. Based on Uncle Mike's Xash3D engine source code.

Currently supports only Windows, we are recruiting developers to port it to other platforms.


**Features:**<br>

<ul><li>Compatibility with most GoldSource modifications.<br>
</li><li>Extended limits.<br>
<ul><li>MAX_EDICTS 600 - 4096 (vs 900 in GoldSource).<br>
</li><li>MAX_TEMPENTS 300 - 2048 (vs 500 in GoldSource).<br>
</li><li>MAX_PARTICLES 1024 - 8192 (vs 4096 in GoldSource).<br>
</li><li>MAX_BEAMS 64 - 512 (vs 64 in GoldSource)<br>
</li><li>MAX_VISIBLE_PACKET 512 - entityes (256 in GoldSource).<br>
</li><li>MAX_MODELS 2048 unique models (includes sprites and bmodels)<br>
</li><li>MAX_SOUNDS 2048<br>
</li><li>MAX_SENTENCES 2048 (1534 in GoldSource)<br>
</li><li>MAX_USER_MESSAGES 191 (128 in WON GoldSource)<br>
</li><li>MAX_TEXTURES 4096 (2048 of them can be used by VGUI)<br>
</li><li>MAX_MESSAGES 2048 (1024 in GoldSource) (max messages in titles.txt)<br>
</li><li>Maximal sizes for indexed textures: 1024x1024 (vs 512x512 in GoldSource)<br>
</li><li>Maximal sizes for truecolor textures: 4096x4096.ent.<br>
</li><li>MAX_MAP_MODELS 1024 (256 in GoldSource)<br>
</li><li>MAX_MAP_LEAFS 32767 (8192 in GoldSource)<br>
</li></ul></li><li>Compatibility with VC2008.<br>
</li><li>Background maps in menus.<br>
</li><li>Quake 1, Half-Life, Half-Life: Blue Shift map compatibility.<br>
</li><li>Dynamic skybox change.<br>
</li><li>Powerful console engine.</li></ul>


<b>These following mods is succesfully completed under Xash3D/Sing engines:</b>

<blockquote>Point Of View<br>
Snark Planet (demo)<br>
Rumble<br>
Lost In Black Mesa (HLFX version)<br>
Ispitatel<br>
Ispitatel II<br>
Ispitatel IV<br>
HLFX Single (demo)<br>
Blue-Shift<br>
Cleaner's Adventures<br>
Uplink<br>
Spirit 1.0, 1.3, 1.7 (demo maps)<br>
HLFX 0.5 (demo maps)<br>
Azure Sheep<br>
Paranoia<br>
Retribution<br>
Invasion (increase max_tempents up to 1024 to prevent possible crashes)<br>
Half-Quake 2: Amen<br>
Half-Quake 3: Sunrise<br>
Half-Quake<br>
The Trap (toggle sv_fix_pushents to '0')<br>
Gunman Chronicles<br>
Black Ops<br></blockquote>


<b>TODO:</b><br>
<ul><li>Full Linux/BSD native support<br>
</li><li>Full Linux/BSD libwine support(for loading already compiled game-modes without source code)<br>
</li><li>IPv6 support<br>
</li><li>Predicting code<br>
</li><li>Our own VGUI system(currently bundled goldsrc's one).<br>