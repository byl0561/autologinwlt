# !/bin/bash

check(){
  ping -c 2 -w 5 www.baidu.com > /dev/null 2>&1
  if [[ $? != 0 ]];then
	ping -c 4 -w 5 www.baidu.com > /dev/null 2>&1
	if [[ $? != 0 ]];then
      echo "Ping fail"
	  connect
	  while [[ $? != 0 ]]
	  do
	    echo "Connect fail, retrying..."
	    connect
	  done
	  echo "Connect success"
	  sleep 15
	fi
  fi
}

connect(){
  echo "Try to connect wls"
  curl http://202.38.64.59/cgi-bin/ip -m 10 -o getIP -s
  if [[ $? != 0 ]];then
	echo "Access fail"
	return 1
  else
	grep -o -m 1 "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" getIP
	if [[ $? != 0 ]];then
	  echo "Cannot find IPAddress, or Access fail"
	  return 1
	fi
  fi
  ip=$(grep -o -m 1 "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" getIP)
  curl http://wlt.ustc.edu.cn/cgi-bin/ip -X POST -H "application/x-www-form-urlencoded" -d "cmd=login&url=URL&ip=${ip}&name=${name}&password=${pass}&go=%B5%C7%C2%BC%D5%CA%BB%A7" -m 10  -o getCookie -s -i
  if [[ $? != 0 ]];then
	echo "Login fail"
	return 1
  else
	grep "^Set-Cookie: rn=" getCookie
	if [[ $? != 0 ]];then
	  echo "Cannot find Set-Cookie, or Login fail"
	  return 1
	fi
  fi
  cookie=$(grep "^Set-Cookie: rn=" getCookie)
  cookie=${cookie#*=}
  cookie=${cookie:0:40}
  curl http://202.38.64.59/cgi-bin/ip?cmd=set\&url=URL\&type=$port\&exp=0\&go=+%BF%AA%CD%A8%CD%F8%C2%E7+ --cookie "name=; password=; rn=$cookie" -m 10 -o result -s
  if [[ $? != 0 ]];then
	echo "Network authentication fail"
	return 1
  fi
  sleep 15
  ping -c 2 -w 5 www.baidu.com > /dev/null 2>&1
  if [[ $? != 0 ]];then
	echo "Ping fail"
	return 1
  fi
}

init(){
  echo "autoLoginWLT 4.1.2-r10 starts"
  echo "username: $name"
  echo "password: $pass"
  case $port in
    0)
        echo "出口：教育网出口(国际,仅用教育网访问,适合看文献)"
        ;;
    1)
        echo "出口：电信网出口(国际,到教育网走教育网)"
        ;;
    2)
        echo "出口：联通网出口(国际,到教育网走教育网)"
        ;;
    3)
        echo "出口：电信网出口2(国际,到教育网免费地址走教育网)"
        ;;
	4)
        echo "出口：联通网出口2(国际,到教育网免费地址走教育网)"
        ;;
    5)
        echo "出口：电信网出口3(国际,默认电信,其他分流)"
        ;;
    6)
        echo "出口：联通网出口3(国际,默认联通,其他分流)"
        ;;
    7)
        echo "出口：教育网出口2(国际,默认教育网,其他分流)"
        ;;
	8)
        echo "出口：移动网出口(国际,无P2P或带宽限制)"
        ;;
    *)
        echo "出口：出口参数错误，使用默认电信网出口"
		port=1
		;;
  esac
}

main(){
  init
  while true
  do
    check
    sleep 60
  done
}

main
