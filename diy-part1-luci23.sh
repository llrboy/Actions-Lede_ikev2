#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
#1. 删除源码自带的 luci-app-ipsec-vpnd
rm -rf feeds/luci/applications/luci-app-ipsec-vpnd

# Add OpenClash
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/luci-app-openclash

git clone https://github.com/Ivaneus/luci-app-ipsec-vpnd package/luci-app-ipsec-vpnd

# Add luci-app-bandix
# git clone https://github.com/timsaya/openwrt-bandix.git package/bandix

# git clone https://github.com/timsaya/luci-app-bandix.git package/luci-app-bandix
# 添加插件
git clone https://github.com/nhhqgirl/luci-app-onliner.git package/lean/luci-app-onliner

git clone --depth=1 -b master https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
