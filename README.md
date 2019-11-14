# Auto Login WLS

---

Auto Login WLS is an open source shell for USTCers to get net access in USTC with their personal campus account and password.

Auto Login WLS ensures that the network connection will not be dropped due to account reasons. Tt is suitable for a variety of scenariosapplies like task servers and NAS, even you just wanna access the Internet after turn on the PC without open the certification page.

Auto Login WLS will connect [baidu.com](http://baidu.com/) periodically to test network connectivity. If the network is broken, It would automatically access [wlt.ustc.edu.cn](http://202.38.64.59/cgi-bin/ip), and then regist network with your account.

Auto Login WLS is deployed in the docker environment as default. In fact, you can deploy it to any environment.

---

## Deploy

### Write name and password as environment variables

Replace the original account and password with your personal campus ones in Dockerfile, then set the port.

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

from
```
	ENV name
	ENV pass
	ENV port
```

to
```
	ENV name "campus account"
	ENV pass "campus password"
	ENV port "0-8"
```

### Build and Run docker image

To build and run docker image, please refer to [docker project](https://www.docker.com/), or you could also run autoLoginWLS.sh in any environment.

## History

### 4.1.0-r8

* Changed docker base-image from centos to alpine to reduce size.

### 4.0.0-r7

* Added ENV port, now it is supported to choose the network export.

* Reduced the SLEEP time in code, now it reconnects faster.

* Added Init code to show ENV settings.

### 3.1.0-r6

* Published on github.