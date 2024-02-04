# Check if fisher is installed
if not functions -q fisher
	echo "========================="
	echo " Fisher is not installed"
	echo "  Execute `fisher_init`"
	echo "========================="
end
