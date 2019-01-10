ifeq ($(PROJECT_ROOT_PATH), )

PROJECT_ROOT_PATH := $(shell pwd)
COMMON_ROOT_PATH := $(PROJECT_ROOT_PATH)/common
endif

export PROJECT_ROOT_PATH
export COMMON_ROOT_PATH

ifeq (, $(PLATFORM))
	PLATFORM = x64_debug
	export PLATFORM
endif

include $(PROJECT_ROOT_PATH)/makerules/build_config.mk
include $(PROJECT_ROOT_PATH)/makerules/env.mk
include $(PROJECT_ROOT_PATH)/makerules/platform.mk
