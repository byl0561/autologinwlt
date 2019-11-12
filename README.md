# Auto Login WLS

---

Auto Login WLS is an open source shell for USTCers to get net access in USTC with their personal campus account and password.

Auto Login WLS ensures that the network connection will not be dropped due to account reasons. Tt is suitable for a variety of scenariosapplies like task servers and NAS, even you just wanna access the Internet after turn on the PC without open the certification page.

Auto Login WLS will connect [baidu.com](http://baidu.com/) periodically to test network connectivity. If the network is broken, It would automatically access [wlt.ustc.edu.cn](http://202.38.64.59/cgi-bin/ip), and then regist network with your account.

Auto Login WLS is deployed in the docker environment as default. In fact, you can deploy it to any environment.

---

## Deploy

### Write name and password as environment variables

Replace the original account and password with your personal campus ones in Dockerfile.

from
```
ENV name
ENV pass
```

to
```
ENV name "campus account"
ENV pass "campus password"
```

### Build and Run docker image

To build and run docker image, please refer to [docker project](https://www.docker.com/), or you could also run autoLoginWLS.sh in any environment.

## History

### 3.1.0-r6

* Published on github.