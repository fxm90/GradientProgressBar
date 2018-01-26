#
# swift-format.sh
# Created by Felix Mau (http://felix.hamburg)
#

function SWIFT_FORMAT()
{
   echo "$(swiftformat . --dryrun --verbose --disable "trailingCommas")"
}

function NUMBER_OF_WARNINGS()
{
   echo $1 | grep "would have updated" -c;
}

SWIFT_FORMAT_RES=$(SWIFT_FORMAT)
echo "$SWIFT_FORMAT_RES"

if [ $(NUMBER_OF_WARNINGS "$SWIFT_FORMAT_RES") -gt 0 ]; then
  exit 1
fi
exit 0