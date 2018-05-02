echo "Starting deploy script..."

echo "Removing previous files from src folder"
rm -rfv src/
unzip mautic/2.13.0.zip -d src/

echo "Removing previous files from deploy folder"
rm -rfv deploy

echo "Generating deploy folder and .zip"
mkdir deploy
zip -r deploy/mautic-docker-deploy.zip * -x mautic/**\* .idea deploy/**\*

docker build .