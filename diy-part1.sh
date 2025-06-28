#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 添加易有云istore插件库
echo -e "\nsrc-git istore https://github.com/linkease/istore;main" >> feeds.conf.default

# Add luci-app-tailscale
rm -rf package/luci-app-tailscale/ >nul
git clone -b main --single-branch https://github.com/asvow/luci-app-tailscale package/luci-app-tailscale

# Add luci-app-easymesh
rm -rf package/luci-app-easymesh/ >nul
# git clone -b master --single-branch https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
git clone https://github.com/torguardvpn/luci-app-easymesh.git package/luci-app-easymesh
