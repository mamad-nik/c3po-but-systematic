#!/bin/bash
flex fb.l
cc lex.yy.c -lfl
./a.out

