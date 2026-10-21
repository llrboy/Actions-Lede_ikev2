#!/bin/bash
# ==========================================================================
# diy-part1.sh 【fw4 nftables 专用 OpenClash】
# 拉取 vernesong OpenClash nftables 分支
# ==========================================================================
echo "【DIY-PART1】开始拉取 nftables 版本 OpenClash"

# 删除旧缓存，防止还是master(iptables)分支
rm -rf package/luci-app-openclash

# 克隆 nftables 分支
git clone -b nftables --depth 1 https://github.com/vernesong/OpenClash.git package/luci-app-openclash

echo "【DIY-PART1】OpenClash nftables分支拉取完成"





# git clone --depth=1 https://github.com/vernesong/OpenClash.git package/luci-app-openclash

git clone --depth=1 -b master https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
