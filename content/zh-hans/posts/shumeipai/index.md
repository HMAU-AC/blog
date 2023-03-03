---
title: "树莓派4B安装宝塔面板"
date: 2022-02-24T08:59:44+08:00
slug: shumeipai
draft: false
toc: true
featured_image: cover.jpg
summary: 树莓派安装BT面板，刚刚开始的时候一堆的问题一次次的尝试解决终于两个夜晚解决了所以问题成功打开了BT面板，哎！！折腾心酸啊，建议有编程基础尝试，毕竟相同的文件可能出现不同的问题，多使用各大搜索平台不要在一个平台找答案。
tags:
  - 树莓派
  - BT面板
categories:
  - 技术
---

树莓派安装BT面板，刚刚开始的时候一堆的问题一次次的尝试解决终于两个夜晚解决了所以问题成功打开了BT面板，哎！！折腾心酸啊，建议有编程基础尝试，毕竟相同的文件可能出现不同的问题，多使用各大搜索平台不要在一个平台找答案。

> 树莓派安装系统可以去官网下载（我使用的是：Debian GNU/Linux 10 (buster)64位）
镜像下载地址：https://www.raspberrypi.org/downloads/raspbian/

### Linux一些命令
```Shell
# 查看系统信息
lsb_release -a
# 查看32和64位数
getconf LONG_BIT
linux系统常用apt(Advanced Package Tool)高级软件工具来安装软件
# 安装软件
sudo apt-get install xxx
# 更新软件列表
sudo apt-get update
# 更新已安装软件
sudo apt-get upgrade
# 删除软件
sudo apt-get remove xxx
# 安装vim编辑器:
sudo apt-get install vim
```
### 写入镜像
百度教程很多不说了
### 配置网络
- 树莓派有屏幕的、网线连接的直接跳过，以下为WiFi连接或手机热点连接需要配置的文件
- WiFi连接或手机热点连接，需要添加几个文件

在BOOT根目录添加：wpa_supplicant.conf和ssh.txt
wpa_supplicant.conf文件写入如下代码：↓
```Shell
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=CN

network={
        ssid="网络名称"
        psk="网络密码"
        key_mgmt=WPA-PSK
}
```
以上做完把SD卡插入树莓派并连接电源等待一会树莓派会自动连接上网，在电脑上连接WiFi或热点（要和树莓派使用同一个网络）使用SSH软件连接默认账号：pi   密码：raspberry
- 华为手机可以在已连接设备里直接看树莓派的IP地址（树莓派名称：raspberrypi）
- 其他手机不知，也可百度寻找其他方法

### 更换Debian源（Debian10）
```Shell
sudo nano /etc/apt/sources.list
```
```Shell
保存修改：ctrl+x——Y——Enter
保存后执行更新：sudo apt update && sudo apt upgrade -y
禁用官方源：在源地址前面加#
```
```Shell
# Debian 10 buster

# 中科大源

deb http://mirrors.ustc.edu.cn/debian buster main contrib non-free
deb http://mirrors.ustc.edu.cn/debian buster-updates main contrib non-free
deb http://mirrors.ustc.edu.cn/debian buster-backports main contrib non-free
deb http://mirrors.ustc.edu.cn/debian-security/ buster/updates main contrib non-free

# deb-src http://mirrors.ustc.edu.cn/debian buster main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian buster-updates main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian buster-backports main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian-security/ buster/updates main contrib non-free

# 官方源

 deb http://deb.debian.org/debian buster main contrib non-free
 deb http://deb.debian.org/debian buster-updates main contrib non-free
 deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free

# deb-src http://deb.debian.org/debian buster main contrib non-free
# deb-src http://deb.debian.org/debian buster-updates main contrib non-free
# deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free

# 网易源

 deb http://mirrors.163.com/debian/ buster main non-free contrib
 deb http://mirrors.163.com/debian/ buster-updates main non-free contrib
 deb http://mirrors.163.com/debian/ buster-backports main non-free contrib
 deb http://mirrors.163.com/debian-security/ buster/updates main non-free contrib

# deb-src http://mirrors.163.com/debian/ buster main non-free contrib
# deb-src http://mirrors.163.com/debian/ buster-updates main non-free contrib
# deb-src http://mirrors.163.com/debian/ buster-backports main non-free contrib
# deb-src http://mirrors.163.com/debian-security/ buster/updates main non-free contrib

# 阿里云

 deb http://mirrors.aliyun.com/debian/ buster main non-free contrib
 deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
 deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib
 deb http://mirrors.aliyun.com/debian-security buster/updates main

# deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib
# deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
# deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib
# deb-src http://mirrors.aliyun.com/debian-security buster/updates main
```

### 放行端口
- Debian/Ubuntu  放行端口

```Shell
安装iptables（通常系统都会自带，如果没有就需要安装）
放行8888端口
iptables -I INPUT -p tcp --dport 8888 -j ACCEPT
然后保存放行规则
iptables-save
设置完就已经放行了指定的端口，但重启后会失效，下面设置持续生效规则；
安装iptables-persistent
apt-get install iptables-persistent
保存规则持续生效
netfilter-persistent save
netfilter-persistent reload
设置完成后指定端口就会持续放行了
```
### 安装BT面板
- 官网Debian安装脚本

```Shell
sudo -i
sudo wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && bash install.sh
```
- 安装完成内网链接访问，访问失败

输入：BT 选择3启动面板服务，再次访问即可
还是不行尝试：（16）在（3）在（14）访问登录


```Shell 
root@shumeipai:~# bt
===============宝塔面板命令行==================
(1) 重启面板服务           (8) 改面板端口
(2) 停止面板服务           (9) 清除面板缓存
(3) 启动面板服务           (10) 清除登录限制
(4) 重载面板服务           (11) 取消入口限制
(5) 修改面板密码           (12) 取消域名绑定限制
(6) 修改面板用户名         (13) 取消IP访问限制
(7) 强制修改MySQL密码      (14) 查看面板默认信息
(22) 显示面板错误日志      (15) 清理系统垃圾
(23) 关闭BasicAuth认证     (16) 修复面板(检查错误并更新面板文件到最新版)
(24) 关闭谷歌认证          (17) 设置日志切割是否压缩
(25) 设置是否保存文件历史副本  (18) 设置是否自动备份面板
(0) 取消
===============================================
请输入命令编号：
===============================================

```
### 配置开机自启动BT
```Shell
# 编辑rc.local文件
vi /etc/rc.local
# 添加如下代码在exit 0之前
sudo /etc/init.d/bt start
```
> rc.local文件如下：

```Shell
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Print the IP address
_IP=$(hostname -I) || true
if [ "$_IP" ]; then
  printf "My IP address is %s\n" "$_IP"
fi

# 添加如下代码：↓
sudo /etc/init.d/bt start

exit 0
```
- 如果vi /etc/rc.local报错
- 执行：rm -f /etc/.rc.local.swp
- 再次执行：vi /etc/rc.local

```Shell
# 错误内容如下：↓
E325: ATTENTION
Found a swap file by the name "/etc/.rc.local.swp"
          owned by: root   dated: Thu Aug 12 11:08:20 2021
         file name: /etc/rc.local
          modified: YES
         user name: root   host name: raspberrypi
        process ID: 1859 (STILL RUNNING)
While opening file "/etc/rc.local"
             dated: Thu Aug 12 11:03:16 2021

(1) Another program may be editing the same file.  If this is the case,
    be careful not to end up with two different instances of the same
    file when making changes.  Quit, or continue with caution.
(2) An edit session for this file crashed.
    If this is the case, use ":recover" or "vim -r /etc/rc.local"
    to recover the changes (see ":help recovery").
    If you did this already, delete the swap file "/etc/.rc.local.swp"
    to avoid this message.

Swap file "/etc/.rc.local.swp" already exists!
[O]pen Read-Only, (E)dit anyway, (R)ecover, (Q)uit, (A)bort:

```
### 内网穿透（实现外网访问）
本站使用的是量子互联的：https://console.uulap.com/
官网使用教程：http://doc.uulap.com/docs/nattunnel/nattunnel-1begluboovg81
1. 内网穿透——我的隧道——线路设置——按需选择（未备案选香港）
2. 内网穿透——我的隧道——开通隧道

- 隧道类型：HTTP80和HTTPS443可以搭建网站
- 隧道名称：随意
- 内网IP：树莓派IP
- 内网端口：默认（80或443）
- 自定义域名：泛域名（www.hmfg.com）

记得在域名服务商解析一下" www "
- 记录类型：CNAME
- 主机记录：www
- 记录值：s2.z100.vip
- 记录值在我的隧道——内网线路：s2.z100.vip

客户端连接SSH
```Shell
#默认pi登切换root
pi@raspberrypi:~ sudo -i
# 进入/root
root@raspberrypi:~ cd /root
# 删除所有nattunnel
root@raspberrypi:~ rm -rf nattunnel*
# 安装arm 32位平台客户端，也可以下载64位
root@raspberrypi:~ wget https://www.uulap.com/download/nattunnel.linux.arm/nattunnel
# 给nattunnel权限
root@raspberrypi:~ chmod +x nattunnel
# 进入nattunnel
root@raspberrypi:~ ./nattunnel
# 网络TOEKN, 在控制台内网穿透——内网列表页面查看
root@raspberrypi:~ nohup /root/nattunnel -t网络TOEKN &
# nohup 命令执行完毕后在按一次回车，才会显示命令提示符
# 原因：它自动添加了：nobup： ignoring input and appending otput to 'nohup.out' 这段需要回车执行

```
### 配置内网穿透开机启动（Ubuntu和Debian）
```Shell
vi /etc/rc.local
# 在exit 0上一行加入
nohup /root/nattunnel -t网络TOEKN > /dev/null &
```
ubuntu 14以后的系统默认没有rc.local文件来配置开机启动，在这里我们需要手动加入rc.local启动服务。

建立rc-local.service文件
sudo vi /etc/systemd/system/rc-local.service
将下列内容复制进rc-local.service文件
```Shell
[Unit]
Description=/etc/rc.local Compatibility
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
```
```Shell
创建文件rc.local
sudo vi /etc/rc.local
```
将下列内容复制进rc.local文件,并将****-****-****-****替换为用户的网络TOKEN
```Shell
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
nohup /root/nattunnel -t****-****-****-**** &
exit 0
```
给rc.local加上权限
```Shell
sudo chmod +x /etc/rc.local
```
启用服务
```Shell
sudo systemctl enable rc-local
```
开机启动设置完成.

### 须知
- 本文源的更换只适用于Debian10其他版本还请移步搜索一下
- 本文使用镜像下载：
- 不管安装BT面板还是LNMP都是很漫长的耐心等待安装