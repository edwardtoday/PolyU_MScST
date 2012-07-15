 ###########################################################################
 ## This file is created automatically from your config file.
 ## Do not hand edit.
 ## Created:Thu Nov 10 18:42:06 HKT 2011
 ###########################################################################

MOD_DESC_NATIVE_AUDIO=(from EST) Native audio module for your system
INCLUDE_NATIVE_AUDIO=1
include $(TOP)/config/modules/EDITLINE.mak
MOD_DESC_SIOD=(from EST) Scheme In One Defun
INCLUDE_SIOD=1
MOD_DESC_WAGON=(from EST) Wagon CART tree system
INCLUDE_WAGON=1
MOD_DESC_SCFG=(from EST) Stochastic context free grammars
INCLUDE_SCFG=1
MOD_DESC_WFST=(from EST) Weighted Finite State Automata
INCLUDE_WFST=1
MOD_DESC_OLS=(from EST) Ordinary Least Squares support
INCLUDE_OLS=1
include $(TOP)/src/modules/RXP/RXP.mak
MOD_DESC_clunits=Unknown Module
INCLUDE_clunits=1
ifeq ($(DIRNAME),src/modules)
    EXTRA_LIB_BUILD_DIRS := $(EXTRA_LIB_BUILD_DIRS)  clunits
endif
MOD_DESC_clustergen=Unknown Module
INCLUDE_clustergen=1
ifeq ($(DIRNAME),src/modules)
    EXTRA_LIB_BUILD_DIRS := $(EXTRA_LIB_BUILD_DIRS)  clustergen
endif
MOD_DESC_MultiSyn=Unknown Module
INCLUDE_MultiSyn=1
ifeq ($(DIRNAME),src/modules)
    EXTRA_LIB_BUILD_DIRS := $(EXTRA_LIB_BUILD_DIRS)  MultiSyn
endif
MOD_DESC_hts_engine=Unknown Module
INCLUDE_hts_engine=1
ifeq ($(DIRNAME),src/modules)
    EXTRA_LIB_BUILD_DIRS := $(EXTRA_LIB_BUILD_DIRS)  hts_engine
endif
include $(TOP)/config/modules/MACOSX_AUDIO.mak
