#!/bin/bash
# 修改后台默认IP地址
sed -i 's/192.168.1.1/192.168.81.1/g' package/base-files/files/bin/config_generate
# 【删除，不存在该文件】
# sed -i 's/192.168.1.1/192.168.81.1/g' package/base-files/luci/bin/config_generate

# 切换内核（注释状态，如需6.18取消注释，注意：6.18对igc驱动有兼容性风险，ESXi直通I225谨慎）
# sed -i 's/^KERNEL_PATCHVER:=6.12/KERNEL_PATCHVER:=6.18/g' target/linux/x86/Makefile

# x86 型号只显示 CPU 型号（Lean源码专属）
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 修改版本为编译日期（Lean源码专属）
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by LERAN/g" package/lean/default-settings/files/zzz-default-settings

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}


# DIY script part2 - 编译中配置：下载OpenClash核心/规则文件（编译阶段自动部署）
# 1. 创建OpenClash核心目录（不存在则创建，确保目录结构完整）
[ -d files/etc/openclash/core ] || mkdir -p files/etc/openclash/core
# 2. 定义各类文件下载地址（保留你原地址，适配x86_64架构）
CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/meta/clash-linux-amd64-v1.tar.gz"
COUNTRY_URL="https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/lite/Country.mmdb"
GEOIP_URL="https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/geoip.dat"
GEOSITE_URL="https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/geosite.dat"
# 3. 下载并部署文件（静默下载，适配编译脚本无交互执行）
echo -e "\033[32m开始下载OpenClash Meta核心及规则文件...\033[0m"
wget -qO- $CLASH_META_URL | tar xOz > files/etc/openclash/core/clash_meta
wget -qO- $COUNTRY_URL > files/etc/openclash/Country.mmdb
wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat
# 4. 赋予核心文件执行权限（确保OpenClash能正常启动核心）
chmod +x files/etc/openclash/core/clash*
# 5. 下载完成提示（方便编译时查看执行状态）
echo -e "\033[32m✅ OpenClash核心、Country.mmdb、GeoIP.dat、GeoSite.dat 下载部署完成！\033[0m"




