cd openwrt

sed -i 's/Os/O3/g' include/target.mk
sed -i 's/O2/O3/g' ./rules.mk
sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

mkdir -p package/base-files/files/etc/openclash/core
cd package/base-files/files/etc/openclash/core
curl -L https://github.com/vernesong/OpenClash/releases/download/Clash/clash-linux-amd64.tar.gz | tar zxf -
chmod +x clash
cd ../../../../../..

cd package/lean

mkdir luci-app-openclash
cd luci-app-openclash
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull origin master
git branch --set-upstream-to=origin/master master
cd ..

git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git
git clone https://github.com/pymumu/smartdns.git
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git

sed -i 's/vpn/services/g' `grep 'vpn' -rl luci-app-zerotier`
sed -i '/VPN/d' `grep 'VPN' -rl luci-app-zerotier`
