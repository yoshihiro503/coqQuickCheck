#!/bin/sh
cat <<EOF | ./top
#load "main.cmo";;
open Coq;;
Main.main;;
EOF
