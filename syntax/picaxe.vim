" Vim syntax file
" Language:    Picaxe
" Last Change: 2014 Aug 17

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax case ignore

" Read the Basic syntax to start with
if version < 600
  so <sfile>:p:h/basic.vim
else
  runtime! syntax/basic.vim
endif

syn match picaxeComment    "'.*"
syn match picaxeComment    ";.*"
syn match picaxeLabel      "\([a-zA-Z][a-zA-Z0-9_]\+\):"

syn keyword picaxeType symbol 
syn match Identifier  "pin\w.\d"
syn match Identifier  "[ABC].\d"
syn match Identifier  "[bB]\d"
syn match Identifier  "outpins[ABC].\d"
syn match Identifier  "cr"
syn match Identifier  "lf"

syn keyword picaxeStatement if then endif goto gosub return branch 
syn keyword picaxeStatement for next end to

syn keyword picaxeFunc pullup
syn keyword picaxeFunc inc dec
syn keyword picaxeFunc high low toggle pulsout
syn keyword picaxeFunc pulsin button
syn keyword picaxeFunc readadc readadc10 calibadc calibadc10
syn keyword picaxeFunc input output reverse let
syn keyword picaxeFunc peek poke
syn keyword picaxeFunc sound play tune
syn keyword picaxeFunc serin serout serrxd sertxd hsersetup hserout hserin
syn keyword picaxeFunc random lookdown lookup
syn keyword picaxeFunc eeprom write read
syn keyword picaxeFunc pause wait nap sleep
syn keyword picaxeFunc setint
syn keyword picaxeFunc servo servopos
syn keyword picaxeFunc infrain infrain2 infraout
syn keyword picaxeFunc readtemp readtemp12
syn keyword picaxeFunc readowsn owin owout readowclk resetowclk
syn keyword picaxeFunc keyin keyled
syn keyword picaxeFunc readi2c writei2c i2cslave i2cin i2cout hi2csetup hi2cin hi2cout
syn keyword picaxeFunc spiin spiout hspisetup hspiin hpsiout
syn keyword picaxeFunc pwm pwmout hpwm
syn keyword picaxeFunc settimer setfreq
syn keyword picaxeFunc hibernate enablebod disablebod
syn keyword picaxeFunc put get @ptr @ptrinc @ptrdec
syn keyword picaxeFunc count
syn keyword picaxeFunc debug

hi def link picaxeComment Comment
hi def link picaxeLabel Label
hi def link picaxeType Type
hi def link picaxeStatement Statement
hi def link picaxeFunc Identifier

