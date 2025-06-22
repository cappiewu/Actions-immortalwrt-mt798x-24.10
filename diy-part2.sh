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


# 添加磊科N60 Pro灯的默认设置
cat << 'EOF' > /tmp/insert_content
while uci -q delete system.@led[0]; do :; done

uci add system led
uci set system.@led[-1].name='SysLoad'
uci set system.@led[-1].sysfs='blue:power'
uci set system.@led[-1].trigger='heartbeat'

uci add system led
uci set system.@led[-1].name='WAN'
uci set system.@led[-1].sysfs='blue:wan'
uci set system.@led[-1].trigger='netdev'
uci set system.@led[-1].dev='wan'
uci add_list system.@led[-1].mode='tx'
uci add_list system.@led[-1].mode='rx'

uci add system led
uci set system.@led[-1].name='USB'
uci set system.@led[-1].sysfs='blue:usb'
uci set system.@led[-1].trigger='usbport'
uci add_list system.@led[-1].port='usb1-port2'

uci add system led
uci set system.@led[-1].name='WLAN'
uci set system.@led[-1].sysfs='blue:wlan'
uci set system.@led[-1].trigger='netdev'
uci set system.@led[-1].dev='rax0'
uci add_list system.@led[-1].mode='tx'
uci add_list system.@led[-1].mode='rx'

uci commit

EOF
sed -i '2r /tmp/insert_content' package/emortal/default-settings/files/99-default-settings-chinese


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

# 调整Ksmbd到NAS网络存储菜单
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-ksmbd/root/usr/share/luci/menu.d/luci-app-ksmbd.json

# 不知道什么原因，padavanonly在2025/6/20的提交27c0f700aedc8546f53b0d41eca67945766b70ca中，把netifd改为了旧版
# 临时调整netifd为最新版本，等待padavanonly更新
sed -i 's/2024-12-17/2025-05-23/g' package/network/config/netifd/Makefile
sed -i 's/ea01ed41f3212ecbe000422f3c122a01b93fe874/7901e66c5f273bceee8981bc8a0c8b0e60945f60/g' package/network/config/netifd/Makefile
sed -i 's/dbaad26c1f9b15d0caff6ccdf80d85b34d96bda72cbd2b1dc188a04136d96c28/8b85ec64e446ae065b1466c520b2d3aae329b6167221e425af903777278f557e/g' package/network/config/netifd/Makefile
