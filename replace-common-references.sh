# Replace references
grep -rl 'portals-common/' src/ | xargs sed -i 's/portals-common/portals-employee/g'
grep -rl 'portals-common/' tests/ | xargs sed -i 's/portals-common/portals-employee/g'
