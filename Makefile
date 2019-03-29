GO_EASY_ON_ME = 1
DEBUG = 0
include $(THEOS)/makefiles/common.mk

export TARGET = iphone:clang:11.2:11.0
export ARCHS = arm64

BUNDLE_NAME = vpnswitch
vpnswitch_BUNDLE_EXTENSION = bundle
vpnswitch_FILES = vpnswitch.mm
vpnswitch_PRIVATE_FRAMEWORKS = ControlCenterUIKit
vpnswitch_INSTALL_PATH = /Library/ControlCenter/Bundles/

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/bundle.mk
