#! /bin/bash

echo "Executing $0"

export limit=$1 
export limit=${limit:=2}
echo "tested limit: $limit"
export numbersInHostName=`echo $HOSTNAME | rev  | cut -d "-" -f 1 | rev | sed -e"s/[^0-9]*//g" |wc -c`
echo numbersInHostName=$numbersInHostName
if [ $numbersInHostName -ge $limit ]; then
	echo "OK"
	exit 0
else
	echo "Not OK"
	exit 1
fi;
