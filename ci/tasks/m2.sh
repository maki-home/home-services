
#/bin/sh

BASEDIR=`pwd`
M2REPO=$BASEDIR/m2/rootfs/opt/m2


DIR="$DIR moneygr"
DIR="$DIR income-outcome"
DIR="$DIR uaa"


if [ "$1" == "init" ]; then
	mkdir -p $M2REPO
fi

cd repo
	for d in $DIR;do
	    echo "++++ Build $d ++++"
	    cd $d
	    $BASEDIR/utils/scripts/add-repos-in-pom-xml.sh
	    artifactId=`./mvnw help:evaluate -Dexpression=project.artifactId -Dmaven.repo.local=$M2REPO | egrep -v '(^\[INFO])'`
		echo $artifactId
	    ./mvnw clean package -Dmaven.repo.local=$M2REPO -DskipTests=true
	    cd ..
	done
cd ..

cd $BASEDIR/m2
	tar -C rootfs -cf rootfs.tar .
	mv rootfs.tar ../to-push
cd ..