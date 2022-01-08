sed -i 's/Os/O3/g' include/target.mk
sed -i 's/O2/O3/g' ./rules.mk
sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

sed -i 's/192.168.1.1/192.168.18.3/g' package/base-files/files/bin/config_generate

curl -s -L $(curl -s 'https://api.github.com/repos/vernesong/OpenClash/releases' | jq -r .[0].tarball_url) | tar zxf -
mv vernesong-OpenClash-* openclash
cd openclash
mkdir core
tar zxfO core-lateset/dev/clash-linux-amd64.tar.gz > core/clash
gunzip -cd core-lateset/premium/clash-linux-amd64-*.gz > core/clash_tun
cd ..

mkdir -p package/base-files/files/etc/openclash
cd package/base-files/files/etc/openclash
mv ../../../../../openclash/core .
cd core
chmod +x clash clash_tun
cd ../../../../../..

mkdir -p package/base-files/files/usr/bin
curl -s -L https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_amd64.tar.gz | tar zxf - ./AdGuardHome/AdGuardHome -O > package/base-files/files/usr/bin/AdGuardHome
chmod +x package/base-files/files/usr/bin/AdGuardHome

cd feeds/luci/applications
sed -i 's/vpn/services/g' `grep 'vpn' -rl luci-app-zerotier`
sed -i '/VPN/d' `grep 'VPN' -rl luci-app-zerotier`
rm -rf luci-app-openclash
mv ../../../openclash/luci-app-openclash .
cd ../../..

rm -rf openclash
