set -e

BUILD_NAME=$1
REPO="DOCKER_REPOSITORY/MY_LOCATION/"
BUILD="docker build --rm -t $BUILD_NAME -f $2 ."

echo $BUILD
$BUILD

TAG="docker tag $BUILD_NAME $REPO$BUILD_NAME"
echo $TAG
$TAG

PUSH="docker push $REPO$BUILD_NAME"
echo $PUSH
$PUSH
