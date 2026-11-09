TARGET = iphone:clang:latest:14.0
ARCHS = arm64 arm64e
TWEAK_NAME = xmly
xmly_FILES = Tweak.xm
xmly_CFLAGS = -fobjc-arc
include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
after-install::
	install.exec "killall -9 ximalaya"
