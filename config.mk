CC              ?=cc
AR              ?=ar
RANLIB          ?=ranlib

CABAL           :=cabal
# IDRIS_ENABLE_STATS should not be set in final release
# Any flags defined here which alter the RTS API must also be added to src/IRTS/CodegenC.hs
CFLAGS          :=-O2 -Wall -DHAS_PTHREAD -DIDRIS_ENABLE_STATS $(CFLAGS)

#CABALFLAGS	:=
## Disable building of Effects
#CABALFLAGS :=-f NoEffects

UNAME         := $(shell uname -a)

ifneq (, $(findstring BSD, $(UNAME)))
	GMP_INCLUDE_DIR      :=
else
	GMP_INCLUDE_DIR      :=-I/usr/local/include
endif

ifneq (, $(findstring Darwin, $(UNAME)))
	OS      :=darwin
else ifneq (, $(findstring CYGWIN, $(UNAME)))
	OS      :=windows
else ifneq (, $(findstring MINGW, $(UNAME)))
	OS      :=windows
else ifneq (, $(findstring MSYS, $(UNAME)))
	OS      :=windows
else
	OS      :=unix
endif

ifeq ($(OS),darwin)
	SHLIB_SUFFIX    :=.dylib
else ifeq ($(OS),windows)
	SHLIB_SUFFIX    :=.DLL
	CC              :=gcc
	GMP_INCLUDE_DIR :="-I$(shell cygpath -w /mingw64/include)"
else
	SHLIB_SUFFIX    :=.so
endif
