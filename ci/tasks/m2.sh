
#/bin/sh

BASEDIR=`pwd`
M2REPO=$BASEDIR/m2/rootfs/opt/m2


DIR="$DIR moneygr"
DIR="$DIR income-outcome"
DIR="$DIR uaa"
DIR="$DIR account"
DIR="$DIR debt"


if [ "$1" == "init" ]; then
	mkdir -p $M2REPO
fi

cd repo
	for d in $DIR;do
	    echo "++++ Build $d ++++"
	    cd $d
	    #$BASEDIR/utils/scripts/add-repos-in-pom-xml.sh
	    artifactId=`./mvnw help:evaluate -Dexpression=project.artifactId -Dmaven.repo.local=$M2REPO | egrep -v '(^\[INFO])'`
		echo $artifactId
		./mvnw versions:set -DnewVersion=1.0 -DallowSnapshots -Dmaven.repo.local=${BASEDIR}/m2/rootfs/opt/m2
	    ./mvnw clean package -Dmaven.repo.local=$M2REPO -DskipTests=true
	    cd ..
	done
cd ..

cd $BASEDIR/m2
        rm -f `find . -name '_remote.repositories' -type f`
	tar -C rootfs -cf rootfs.tar .
	mv rootfs.tar ../to-push
cd ..
