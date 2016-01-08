#!/bin/bash
#
# getface.sh
#
# Monitorar visitas no perfil do FaceBook
# Necessita do Lynx. # apt-get install lynx
# ins3ct, Junho 2015
#
 
qtde=$2
 
cat $1 |
        tr -d '[]{}":;\\/_?=.' |
        sed 's/[a-zA-Z]//g' |
        tr ',' '\n&' |
        egrep "^[0-9]{8}" |
        grep '-' |
        uniq |
        tr '-' '\n&' |
        egrep "[0-9]{8}" |
        head -n $qtde |
        sed '1d' > ids.lst
 
lines=$(wc -l ids.lst)
num=1
 
echo
echo "Lista de pessoas que mais visitaram seu perfil:"
echo
 
while [ $num -lt $2 ]
do
        id=$(sed -n "$num p" ids.lst)
        lynx -source m.facebook.com/profile.php?id=$id |
        tr '"' '\n&' |
        grep -A 1 title= |
        sed '1d'
 
        let "num = num + 1"
        sleep 1
done
 
echo
echo "Fim da Lista."
