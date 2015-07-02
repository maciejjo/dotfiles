" Vim syntax file
" Language:	FSM syslog files coloring
" Maintainer:	Piotr Rotter piotr.rotter@nsn.com

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn keyword gpsd_related         gpsd
syn match  PPS_clk_event_timeout "PPS clk event timeout"
syn match  PPS_clk_event_failure "PPS clk event failure"
syn match  PPS_clk_event_arrived "PPS clk event arrived"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_basic_syntax_inits")
  if version < 508
    let did_fsm_syslog_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink gpsd_related		Type
  HiLink PPS_clk_event_timeout  Number
  HiLink PPS_clk_event_failure  Error
  HiLink PPS_clk_event_arrived  Special
  
  HiLink basicFilenumber basicTypeSpecifier
  "hi basicMathsOperator term=bold cterm=bold gui=bold

  delcommand HiLink
endif

let b:current_syntax = "fsm_syslog"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: ts=8
