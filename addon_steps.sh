cd openwrt

sed -i 's/Os/O3/g' include/target.mk
sed -i 's/O2/O3/g' ./rules.mk
sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

mkdir -p package/base-files/files/etc/openclash/core
cd package/base-files/files/etc/openclash/core
curl -L https://github.com/vernesong/OpenClash/releases/download/Clash/clash-linux-amd64.tar.gz | tar zxf -
chmod +x clash
cd ../../../../../..

mkdir -p package/base-files/files/usr/bin
mkdir download_temp
cd download_temp
curl -L https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_amd64.tar.gz | tar zxf -
cd AdGuardHome
chmod +x AdGuardHome
mv AdGuardHome ../../package/base-files/files/usr/bin
cd ../..
rm -rf download_temp

# cd package/lean
# sed -i 's/vpn/services/g' `grep 'vpn' -rl luci-app-zerotier`
# sed -i '/VPN/d' `grep 'VPN' -rl luci-app-zerotier`
# cd ../..
