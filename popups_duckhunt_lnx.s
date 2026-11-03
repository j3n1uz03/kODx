alias dh.logo { return $b($c(03,$sep2)) $+ $bracket($c(10,$chars.utf8.2(DuckHunt)) $c(07,$chars.ng2(LNx))) $+ $b($c(03,$chars(rightsmallarrowfull))) $+  } 

alias b { return  $+ $1- $+  }
alias bi { return  $+ $1- $+  }
alias i { return  $+ $1- $+  }
alias u { return  $+ $1- $+  }
alias c { return  $+ $1 $+ $2- }
alias bracket { return $c($color.sep,$chars(leftbracket2)) $+ $1- $+ $c($color.sep,$chars(rightbracket2)) }


alias chars.utf8.2 {
  var %s = $1-
  var %out = $replacecs(%s,a,𝒶,b,𝒷,c,𝒸,d,𝒹,e,ℯ,f,𝒻,g,ℊ,h,𝒽,i,𝒾,j,𝒿,k,𝓀,l,𝓁,m,𝓂,n,𝓃,o,ℴ,p,𝓅,q,𝓆,r,𝓇,s,𝓈,t,𝓉,u,𝓊,v,𝓋,w,𝓌,x,𝓍,y,𝓎,z,𝓏,A,𝒜,B,ℬ,C,𝒞,D,𝒟,E,ℰ,F,ℱ,G,𝒢,H,ℋ,I,ℐ,J,𝒥,K,𝒦,L,ℒ,M,ℳ,N,𝒩,O,𝒪,P,𝒫,Q,𝒬,R,ℛ,S,𝒮,T,𝒯,U,𝒰,V,𝒱,W,𝒲,X,𝒳,Y,𝒴,Z,𝒵)
  return %out
}

alias chars.ng2 {
  var %s = $1-
  var %out = $replacecs(%s,a,ᴀ,b,ʙ,c,ᴄ,d,ᴅ,e,ᴇ,f,ꜰ,g,ɢ,h,ʜ,i,ɪ,j,ᴊ,k,ᴋ,l,ʟ,m,ᴍ,n,ɴ,o,ᴏ,p,ᴘ,q,q,r,ʀ,s,ꜱ,t,ᴛ,u,ᴜ,v,ᴠ,w,ᴡ,x,x,y,ʏ,z,ᴢ,A,ᴀ,B,ʙ,C,ᴄ,D,ᴅ,E,ᴇ,F,ꜰ,G,ɢ,H,ʜ,I,ɪ,J,ᴊ,K,ᴋ,L,ʟ,M,ᴍ,N,ɴ,O,ᴏ,P,ᴘ,Q,Q,R,ʀ,S,ꜱ,T,ᴛ,U,ᴜ,V,ᴠ,W,ᴡ,X,x,Y,ʏ,Z,ᴢ)
  return %out
}

on *:LOAD:{
  if (!%dh.pub) set %dh.pub on
  echo -a $dh.logo $c(15,loaded. Right-click > Duck Hunt > Setup > Set bot nick - and other settings)
}

; ------------------------------ command names --------------------------------

alias dh.def {
  var %d = bang:!bang bef:!bef luv:!luv reload:!reload reload2:!r stats:!duckstats top:!topduck last:!lastduck help:!duckhelp allstats:!allstats shop:!shop pets:!pets inv:!inv use:!use nuke:!nuke food:!food unarm:!unarm rearm:!rearm pmhelp:help pmlast:lastduck find:findplayer fusion:fusion rename:rename delete:delete ducklaunch:ducklaunch export:export plan:planning replan:replanning pmall:!allstats
  return $gettok($wildtok(%d,$1 $+ :*,1,32),2,58)
}
; Configured name (set via Setup) or the default.
alias dh.cmd {
  var %v = $($+(%,dh.cmd.,$1),2)
  if (%v) return %v
  return $dh.def($1)
}

; ------------------------------- core aliases --------------------------------

alias dh.bot {
  if (%dh.bot) return %dh.bot
  if ($window($active).type == query) { set %dh.bot $active | return $active }
  var %n = $$?="Duck Hunt bot nick"
  set %dh.bot %n
  return %n
}

; Channel for public commands / admin PM commands.
alias dh.chan {
  if ($active ischan) return $active
  if (%dh.defchan) return %dh.defchan
  var %c = $$?="Channel (#chan)"
  return %c
}

; /dh.pub <name> [args]  - public command into the channel
alias dh.pub msg $dh.chan $dh.cmd($1) $2-

; /dh.pm <name> [args]   - admin command to the bot, channel first
alias dh.pm msg $dh.bot $dh.cmd($1) $dh.chan $2-

; /dh.pmn <name> [args]  - admin command to the bot, no channel
alias dh.pmn msg $dh.bot $dh.cmd($1) $2-

; Shop: items that need a target nick (mirror, sand, bucket, sabotage)
alias dh.shop {
  if ($1 isnum 14-17) { dh.pub shop $1 $$?="Target nick" | return }
  dh.pub shop $1
}
alias dh.use {
  if ($1 isnum 14-17) { dh.pub use $1 $$?="Target nick" | return }
  dh.pub use $1
}

; $submenu generators ---------------------------------------------------------
alias dh.items {
  var %n = Extra bullet,Extra clip,AP ammo,Explosive ammo,Repurchase confiscated gun,Grease,Sight,Infrared detector,Silencer,Four-leaf clover,Sunglasses,Spare clothes,Brush for gun,Mirror (target),Handful of sand (target),Water bucket (target),Sabotage (target),Life insurance,Liability insurance,Decoy,Piece of bread,Ducks detector,Mechanical duck,Friendship Bracelet,Duck Treats,Love Potion,Love Letter,Lullaby,Soulmate Charm,Bag of Seeds,Nuke
  if ($1 isnum 1-31) return $1 - $gettok(%n,$1,44) $+ :dh.shop $1
}
alias dh.useitems {
  var %ids = 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29
  ; storable items (inv_items in Duck_Hunt.tcl): 3 4 6-29
  var %names = AP ammo,Explosive ammo,Grease,Sight,Infrared detector,Silencer,Four-leaf clover,Sunglasses,Spare clothes,Brush for gun,Mirror (target),Handful of sand (target),Water bucket (target),Sabotage (target),Life insurance,Liability insurance,Decoy,Piece of bread,Ducks detector,Mechanical duck,Friendship Bracelet,Duck Treats,Love Potion,Love Letter,Lullaby,Soulmate Charm
  if ($1 isnum 1- $+ $numtok(%ids,32)) return $gettok(%ids,$1,32) - $gettok(%names,$1,44) $+ :dh.use $gettok(%ids,$1,32)
}
alias dh.exports {
  var %l = nick last_activity xp level xp_lvl_up gun ammo max_ammo ammo_clips max_clips accuracy effective_accuracy deflection defense jamming jammed jammed_nbr confisc ducks golden_ducks missed empty accidents wild_shots total_ammo shot_at neutralized deflected deaths best_time average_reflex_time karma rank items
  if ($1 isnum 1- $+ $numtok(%l,32)) return $gettok(%l,$1,32) $+ :dh.pmn export $gettok(%l,$1,32)
}
alias dh.cmdnames {
  var %l = bang bef luv reload stats top last help allstats shop pets inv use nuke food unarm rearm pmhelp pmlast find fusion rename delete ducklaunch export plan replan
  if ($1 isnum 1- $+ $numtok(%l,32)) return $gettok(%l,$1,32) $+ ( $+ $dh.cmd($gettok(%l,$1,32)) $+ ):dh.setcmd $gettok(%l,$1,32)
}
alias dh.setcmd {
  var %v = $$?="New command name for $1 (current: $dh.cmd($1) $+ ). Empty = default"
  if (%v) { set % $+ dh.cmd. $+ $1 %v }
  else { unset % $+ dh.cmd. $+ $1 }
  echo -a $dh.logo $c(14,$1 = $dh.cmd($1))
}

; ---------------------------------- menus ------------------------------------

menu channel,query {
  $strip($dh.logo)
  .Hunt
  ..bang (shoot):dh.pub bang
  ..bef (befriend):dh.pub bef
  ..luv (shower with love):dh.pub luv
  ..-
  ..reload (unjam / reload):dh.pub reload
  ..-
  ..food (my food):dh.pub food
  ..food of a hunter...:dh.pub food $$?="Hunter nick"
  ..food rates:dh.pub food rates
  ..food give...:dh.pub food give $$?="Hunter nick" $$?="Amount"
  .Stats
  ..duckstats (mine):dh.pub stats
  ..duckstats of a hunter...:dh.pub stats $$?="Hunter nick"
  ..-
  ..topduck:dh.pub top
  ..lastduck:dh.pub last
  ..allstats:dh.pub allstats
  ..allstats for a channel...:dh.pub allstats $$?="#chan"
  ..-
  ..duckhelp:dh.pub help
  .Shop
  ..shop (list items):dh.pub shop
  ..shop pet (list pets):dh.pub shop pet
  ..-
  ..Buy item
  ...$submenu($dh.items($1))
  ..-
  ..Buy by number...:dh.shop $$?="Item number (1-31)"
  .Inventory
  ..inv (show bag):dh.pub inv
  ..-
  ..Use item
  ...$submenu($dh.useitems($1))
  ..Use by number...:dh.use $$?="Item number"
  ..-
  ..nuke (fire it):dh.pub nuke
  .Pets
  ..pets (list):dh.pub pets
  ..adopt (by number)...:dh.pub pets $$?="Pet number"
  ..feed:dh.pub pets feed
  ..treat:dh.pub pets treat
  ..info:dh.pub pets info
  ..release:if ($input(Release your pet?,yq,Duck Hunt)) dh.pub pets release
  .-
  .Channel admin (public)
  ..unarm (confiscate gun)...:dh.pub unarm $$?="Hunter nick"
  ..unarm -static (stays confiscated)...:dh.pub unarm -static $$?="Hunter nick"
  ..rearm (give gun back)...:dh.pub rearm $$?="Hunter nick"
  .Bot admin (private message)
  ..help:dh.pmn pmhelp
  ..help full:dh.pmn pmhelp full
  ..lastduck (channel)...:dh.pm pmlast
  ..-
  ..findplayer...:dh.pm find $$?="Search text"
  ..allstats (PM, channel)...:dh.pm pmall
  ..-
  ..Export players table
  ...default (by nick):dh.pmn export
  ...By field
  ....$submenu($dh.exports($1))
  ..-
  ..fusion (merge hunters)...:dh.pm fusion $$?="Destination nick" $$?="Source nick(s), space separated"
  ..rename hunter...:dh.pm rename $$?="Old nick" $$?="New nick"
  ..delete hunter...:if ($input(Delete this hunter for good?,yq,Duck Hunt)) dh.pm delete $$?="Hunter nick"
  ..-
  ..launch a duck:dh.pm ducklaunch 0
  ..launch a golden duck:dh.pm ducklaunch 1
  ..launch a flock:dh.pm ducklaunch flock
  ..-
  ..planning (today's flights):dh.pm plan
  ..replanning (re-plan flights):dh.pm replan
  .-
  .Setup
  ..Set bot nick...:set %dh.bot $$?="Duck Hunt bot nick" | echo -a $dh.logo $c(14,bot = %dh.bot)
  ..Set default channel (for query use)...:set %dh.defchan $$?="Default channel (#chan)" | echo -a $dh.logo $c(14,default channel = %dh.defchan)
  ..Clear default channel:unset %dh.defchan | echo -a $dh.logo $c(14,default channel cleared)
  ..-
  ..Set command name
  ...$submenu($dh.cmdnames($1))
  ..Reset all command names to defaults:unset %dh.cmd.* | echo -a $dh.logo $c(14,command names reset to defaults)
  ..-
  ..Show current settings:echo -a $dh.logo $c(14,bot= $+ %dh.bot - chan= $+ %dh.defchan)
}
