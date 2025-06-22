#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 修改默认IP
sed -i 's/192.168.6.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# 修改默认主机名
#sed -i "s/hostname='.*'/hostname='N60Pro'/g" package/base-files/files/bin/config_generate

# 添加“网络存储”
echo -e "\nmsgid \"NAS\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
echo -e "msgstr \"网络存储\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

# 修改默认镜像源
sed -i "s/mirrors\.vsean\.net\/openwrt/mirror\.nju\.edu\.cn\/immortalwrt/g" package/emortal/default-settings/files/99-default-settings-chinese

# Modify tailscale Makefile
sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile

# 调整PassWall到VPN菜单
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/controller/*.lua
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/passwall/*.lua
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/view/passwall/socks_auto_switch/*.htm
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/view/passwall/global/*.htm
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/view/passwall/log/*.htm
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/view/passwall/rule/*.htm
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-passwall/luasrc/view/passwall/server/*.htm
