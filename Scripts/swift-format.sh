#
# swift-format.sh
# Created by Felix Mau (http://felix.hamburg)
#

# Run swiftformat without touching files
SWIFT_FORMAT_RESULT="$(swiftformat . --dryrun --verbose --disable "trailingCommas")"
echo "$SWIFT_FORMAT_RESULT"

# Break build on any found warning
echo $SWIFT_FORMAT_RESULT | grep "would have updated" --quiet --invert-match