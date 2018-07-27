#!/bin/bash -e

##########################################################################################
# Abash script to test cipher suites. 
# It gets a list of supported cipher suites from OpenSSL and tries to connect using each one. 
# If the handshake is successful, it prints YES. If the handshake isn't successful, it prints NO, followed by the OpenSSL error text.
# 
# Source: http://superuser.com/questions/109213/how-do-i-list-the-ssl-tls-cipher-suites-a-particular-website-offers
#
# Author:
#  Ruifeng Ma <ruifengm@sg.ibm.com>
# Date:
#  2017-May-01
##########################################################################################

####################################################################################################################################

####################################################################################################################################

# SSL_RSA_WITH_RC4_128_MD5 (JSSE name)       >>>   RC4-MD5(opensl name)
# SSL_RSA_WITH_RC4_128_SHA (JSSE name)       >>>   RC4-SHA(opensl name)
# SSL_RSA_WITH_3DES_EDE_CBC_SHA (JSSE name)  >>>   DES-CBC3-SHA (openssl name)

# openssl s_client -cipher DES-CBC3-SHA -connect 10.120.134.40:9043
# openssl s_client -cipher RC4-SHA -connect 10.120.134.40:9043
# openssl s_client -connect 10.120.134.40:9443 -ssl3
# openssl s_client -connect 9.51.192.11:9443 -ssl3

# OpenSSL requires the port number.
# SERVER=10.120.134.40:9043
SERVER=sla-bvt-ee-sjc01.sdad.sl.dst.ibm.com:3333
DELAY=1
ciphers=$(openssl ciphers 'ALL:eNULL' | sed -e 's/:/ /g')

echo Obtaining cipher list from $(openssl version).

for cipher in ${ciphers[@]}
do
# echo -n Testing $cipher...
result=$(echo -n | openssl s_client -cipher "$cipher" -connect $SERVER 2>&1)
if [[ "$result" =~ ":error:" ]] ; then
  # echo -n Testing $cipher...
  # error=$(echo -n $result | cut -d':' -f6)
  # echo NO \($error\)
  echo -n
else
  if [[ "$result" =~ "Cipher is ${cipher}" || "$result" =~ "Cipher    :" ]] ; then
  	echo -n Testing $cipher...
  	protocol=$(echo -n $result | grep -Po 'Protocol : \K[^ ]*')    # \K keeps the text matched so far out of the overall regex match
    echo YES \(Protocol: $protocol\)
  else
  	echo -n Testing $cipher...
    echo UNKNOWN RESPONSE
    echo $result
  fi
fi
sleep $DELAY
done


echo -e "End of script."