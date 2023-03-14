---
title: "Linux问题汇总"
date: 2023-03-05T21:00:44+08:00
slug: linux-wenti
featured_image: cover.png
summary: linux使用过程中一些比较烦人的小问题的解决方法，网络上好多都杂乱无章，自己记录一下有用的
tags:
  - Linux问题
  - Unbentu启动
categories:
  - 技术
---



### 解决启动Unbentu启动后还要在选一次unbentu的问题

``` shell

cd /etc/default/
sudo vim grub
GRUB_TIMEOUT=10  //10改称0 如图2

i     //编辑
esc   //退出编辑
:wq   //保存

```
![1](1.png)
![2](2.png)

```shell

cd /etc/     //如果还在default目录则输入：cd ../  退到上级目录etc/
sudo vim grub.d

30_os-prober*   //上下键选择到这个回车（Enter）  如图3
```

```shell
// 找到如下代码：👇

adjust_timeout () {
  if [ "$quick_boot" = 1 ] && [ "x${found_other_os}" != "x" ]; then
    cat << EOF
set timeout_style=menu
if [ "\${timeout}" = 0 ]; then
  set timeout=10    //这的10改0  如图4
fi
EOF
  fi
}

i     //编辑
esc   //退出编辑
:wq   //保存

```
![3](3.png)
![4](4.png)

 > 重点两个改完一定要执行下面命令使grub生效
 
```shell
sudo update-grub

```


