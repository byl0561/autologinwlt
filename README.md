# Auto Login WLT

---

Auto Login WLT 是一个Shell脚本，可自动连接USTC校园网认证服务，并确保不会由于网络波动等原因而断开网络连接。

Auto Login WLT 将定期连接 [baidu.com](http://baidu.com/) 以测试网络连接。 如果网络断开，它将自动访问 [wlt.ustc.edu.cn](http://202.38.64.59/cgi-bin/ip) ，然后使用您的帐户注册网络。

---

## 部署

### 设置环境变量

设置账户`name`，密码`pass`，出口`port`

|port|网络出口|
|:-:|:-:|
|0|1教育网出口(国际,仅用教育网访问,适合看文献)|
|1|2电信网出口(国际,到教育网走教育网)|
|2|3联通网出口(国际,到教育网走教育网)|
|3|4电信网出口2(国际,到教育网免费地址走教育网)|
|4|5联通网出口2(国际,到教育网免费地址走教育网)|
|5|6电信网出口3(国际,默认电信,其他分流)|
|6|7联通网出口3(国际,默认联通,其他分流)|
|7|8教育网出口2(国际,默认教育网,其他分流)|
|8|9移动网出口(国际,无P2P或带宽限制)|

如`Dockerfile`文件中：
```
	ENV name
	ENV pass
	ENV port
```

改为
```
	ENV name "campus account"
	ENV pass "campus password"
	ENV port "0-8"
```

### 构建Docker镜像

镜像构建方式，请参见Docker官方文档 [docker project](https://www.docker.com/), 或者您也可以直接运行`autoLoginWLT.sh`。

## 历史版本

### 4.1.3-r11

* Fix bug.

### 4.1.2-r10

* Minimize log.

### 4.1.1-r9

* Fix bug.

### 4.1.0-r8

* Change docker base-image from centos to alpine to reduce size.

### 4.0.0-r7

* Add ENV port, now it is supported to choose the network export.

* Reduce the SLEEP time in code, now it reconnects faster.

* Add Init code to show ENV settings.

### 3.1.0-r6

* Publish on github.
