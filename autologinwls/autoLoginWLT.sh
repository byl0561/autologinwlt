# !/bin/bash

check(){
  ping -c 2 -w 5 www.baidu.com > /dev/null 2>&1
  if [[ $? != 0 ]];then
    echo "Ping fail, try again..."
	sleep 10
	ping -c 4 -w 5 www.baidu.com > /dev/null 2>&1
	if [[ $? != 0 ]];then
      echo "Ping fail"
	  connect
	  while [[ $? != 0 ]]
	  do
	    echo "Connect fail, retrying..."
	    sleep 5
	    connect
	  done
	  echo "Connect success"
	  sleep 15
	else
	  echo "Ping success"
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
	echo "Access success"
	sleep 1
  fi
  ip=$(grep -o -m 1 "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" getIP)
  curl http://202.38.64.59/cgi-bin/ip -X POST -H "application/x-www-form-urlencoded" -d "cmd=login&url=URL&ip=${ip}&name=${name}&password=${pass}&set=%B5%C7%C2%BC%D5%CA%BB%A7" -m 10  -o getCookie -s -i
  if [[ $? != 0 ]];then
	echo "Login fail"
	return 1
  else
	grep "^Set-Cookie: rn=" getCookie
	if [[ $? != 0 ]];then
	  echo "Cannot find Set-Cookie, or Login fail"
	  return 1
	fi
	echo "Login success"
	sleep 1
  fi
  cookie=$(grep "^Set-Cookie: rn=" getCookie)
  cookie=${cookie#*=}
  cookie=${cookie:0:40}
  curl http://202.38.64.59/cgi-bin/ip?cmd=set\&url=URL\&type=7\&exp=0\&go=+%BF%AA%CD%A8%CD%F8%C2%E7+ --cookie "name=; password=; rn=$cookie" -m 10 -o result -s
  if [[ $? != 0 ]];then
	echo "Network authentication fail"
	return 1
  else
	echo "Network authentication success"
  fi
  sleep 15
  ping -c 2 -w 5 www.baidu.com > /dev/null 2>&1
  if [[ $? != 0 ]];then
	echo "Ping fail"
	return 1
  else
	echo "Ping success"
	sleep 1
  fi
}

main(){
  echo "autoLoginWLT 3.1.0-r6 starts"
  while true
  do
    check
    sleep 5
  done
}

main
