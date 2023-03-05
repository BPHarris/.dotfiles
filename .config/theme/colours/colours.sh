#!/bin/sh
if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P0080808
  \e]P1cf4f43
  \e]P254964f
  \e]P3d17536
  \e]P41b4666
  \e]P55e196d
  \e]P65e8b8d
  \e]P7646464
  \e]P8323232
  \e]P9993e36
  \e]PA5c8b59
  \e]PBaa9c30
  \e]PC1267a5
  \e]PD8910ad
  \e]PE61c4c6
  \e]PFe0e0e0
  "
  # get rid of artifacts
  clear
fi
