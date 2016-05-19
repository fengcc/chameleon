# chameleon
实现一种WiFi路由器伪装技术，代号变色龙chameleon，以便使变色龙附近的手机（STA,station)能自动关联认证，以使WiFi技术拥有更好的使用体验和更大的覆盖范围。

- hostapd-2.0目录里是适合在电脑上运行的版本
- hostapd-OpenWrt里是移植到OpenWrt中的版本，可直接打包压缩替换原版压缩包。**注意**，此代码已经打过patch，所以要将OpenWrt中对hostapd打的patch文件删掉，否则编译会报错。
