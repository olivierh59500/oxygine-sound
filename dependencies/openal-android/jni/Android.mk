ifeq ("$(ROOTDIR)","")
    LOCAL_PATH := $(call my-dir)
else
    LOCAL_PATH := $(ROOTDIR)
endif

ANALYZE      ?= no
ANALYZE_OUTPUT?=/dev/null

include $(CLEAR_VARS)
TARGET_ARCH_ABI  ?=armeabi-v7a
LOCAL_MODULE     := openal
LOCAL_ARM_MODE   := arm
CLANG_VERSION    ?= 3.1
ROOTDIR          ?= $(LOCAL_PATH)
OPENAL_DIR       := OpenAL
MODULE           := openal
MODULE_DST       := obj/local/$(TARGET_ARCH_ABI)/objs/openal
ifeq ("$(BINDIR)","")
    BINDIR       := $(abspath $(ROOTDIR)/../obj/local/$(TARGET_ARCH_ABI)/objs/ )
else
    BINDIR       := $(abspath $(BINDIR) )
endif

 
LOCAL_CFLAGS    +=  -I$(ROOTDIR)/$(OPENAL_DIR) \
                    -I$(ROOTDIR)/$(OPENAL_DIR)/include \
                    -I$(ROOTDIR)/$(OPENAL_DIR)/OpenAL32/Include \
                    -DAL_ALEXT_PROTOTYPES \
                    -DANDROID \
                    -fpic \
                    -ffunction-sections \
                    -funwind-tables \
                    -fstack-protector \
                    -fno-short-enums \
                    -DHAVE_GCC_VISIBILITY \
                    -O3 \
                    -g \
 

MAX_SOURCES_LOW ?= 4
MAX_SOURCES_START ?= 8
MAX_SOURCES_HIGH ?= 64
LOCAL_CFLAGS += -DMAX_SOURCES_LOW=$(MAX_SOURCES_LOW) -DMAX_SOURCES_START=$(MAX_SOURCES_START) -DMAX_SOURCES_HIGH=$(MAX_SOURCES_HIGH)

LOCAL_SRC_FILES :=  \
                    $(OPENAL_DIR)/Alc/android.c              \
                    $(OPENAL_DIR)/Alc/opensles.c             \
                    $(OPENAL_DIR)/OpenAL32/alAuxEffectSlot.c \
                    $(OPENAL_DIR)/OpenAL32/alBuffer.c        \
                    $(OPENAL_DIR)/OpenAL32/alDatabuffer.c    \
                    $(OPENAL_DIR)/OpenAL32/alEffect.c        \
                    $(OPENAL_DIR)/OpenAL32/alError.c         \
                    $(OPENAL_DIR)/OpenAL32/alExtension.c     \
                    $(OPENAL_DIR)/OpenAL32/alFilter.c        \
                    $(OPENAL_DIR)/OpenAL32/alListener.c      \
                    $(OPENAL_DIR)/OpenAL32/alSource.c        \
                    $(OPENAL_DIR)/OpenAL32/alState.c         \
                    $(OPENAL_DIR)/OpenAL32/alThunk.c         \
                    $(OPENAL_DIR)/Alc/ALc.c                  \
                    $(OPENAL_DIR)/Alc/alcConfig.c            \
                    $(OPENAL_DIR)/Alc/alcEcho.c              \
                    $(OPENAL_DIR)/Alc/alcModulator.c         \
                    $(OPENAL_DIR)/Alc/alcReverb.c            \
                    $(OPENAL_DIR)/Alc/alcRing.c              \
                    $(OPENAL_DIR)/Alc/alcThread.c            \
                    $(OPENAL_DIR)/Alc/ALu.c                  \
                    $(OPENAL_DIR)/Alc/bs2b.c                 \
                    $(OPENAL_DIR)/Alc/null.c                 \
                    $(OPENAL_DIR)/Alc/panning.c              \
                    $(OPENAL_DIR)/Alc/mixer.c                \
                    $(OPENAL_DIR)/Alc/audiotrack.c           \


# If building for versions after FROYO

LOCAL_CFLAGS +=   -DPOST_FROYO






include $(BUILD_STATIC_LIBRARY)