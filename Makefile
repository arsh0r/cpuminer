#
# Copyright (C) 2013 
#                           
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
 
include $(TOPDIR)/rules.mk
 
PKG_NAME:=cpuminer
PKG_VERSION:=2.5.1
PKG_RELEASE:=1
PKG_FILE_DEPEND:=./src

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
 
define Package/cpuminer
	MAINTAINER:=
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=cpuminer (CPU Miner)
	URL:=https://github.com/pooler/cpuminer
	DEPENDS:=+libcurl +libpthread +libncurses +jansson
endef
 
define Package/cpuminer/description
Cpuminer is a multi-threaded CPU miner for bitcoin and derivative
coins. Do not use on multiple block chains at the same time!
endef
 
CONFIGURE_ARGS +=
TARGET_CFLAGS  += -O2
TARGET_LDFLAGS += -Wl,-rpath-link=$(STAGING_DIR)/usr/lib
 
define Build/Configure
	# Need to remake configure etc to pick up on cross-compiler libtool
	( cd $(PKG_BUILD_DIR); ./autogen.sh; )
 
	$(call Build/Configure/Default)
endef
 
define Package/cpuminer/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/minerd $(1)/usr/bin
endef
 
$(eval $(call BuildPackage,cpuminer))
