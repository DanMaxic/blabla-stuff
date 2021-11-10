#!/bin/sh
set +e

nodes_request=$(curl --header "Content-Type: application/json" --request POST --data  '{"configuration":["nodes"] }' $HUB_PORT_4444_TCP_ADDR:$HUB_PORT_4444_TCP_PORT/grid/api/hub -s --connect-timeout 10 --max-time 20 )
request=$(curl --header "Content-Type: application/json" --request GET  $HUB_PORT_4444_TCP_ADDR:$HUB_PORT_4444_TCP_PORT/grid/api/hub -s --connect-timeout 30 --max-time 30 ) 
nodes_request=$(echo $nodes_request | jq -R 'fromjson? | select(type == "object")')
request=$(echo $request | jq -R 'fromjson? | select(type == "object")')


[ -z "${nodes_request}" ] && nodes_request='{"nodes":[], "slotCounts": {"total":0, "free":0}, "newSessionRequestCount": 0}'
[ -z "${request}" ] && request='{"nodes":[], "slotCounts": {"total":0, "free":0}, "newSessionRequestCount": 0}'

selenium_hub_nodecount_total=$(echo $nodes_request | jq '.nodes | length')
selenium_hub_slotcount_free=$(echo $request | jq '.slotCounts.free')
selenium_hub_slotcount_total=$(echo $request | jq '.slotCounts.total')
selenium_hub_slotcount_inuse=$(expr ${selenium_hub_slotcount_total} - ${selenium_hub_slotcount_free})
newSessionRequestCount=$(echo $request | jq '.newSessionRequestCount')
[ "${selenium_hub_slotcount_total}" -eq 0 ] && selenium_hub_slotcount_total=1

selenium_hub_stress=$(echo "scale=2; 100 * ${selenium_hub_slotcount_inuse} / ${selenium_hub_slotcount_total}" |  bc | awk '{printf "%.2f", $0}' )

[ -z "${selenium_hub_nodecount_total}" ] && selenium_hub_nodecount_total=0
[ -z "${selenium_hub_slotcount_free}" ] && selenium_hub_slotcount_free=0
[ -z "${selenium_hub_slotcount_total}" ] && selenium_hub_slotcount_total=0
[ -z "${selenium_hub_slotcount_inuse}" ] && selenium_hub_slotcount_inuse=0
[ -z "${newSessionRequestCount}" ] && newSessionRequestCount=0
[ -z "${selenium_hub_stress}" ] && selenium_hub_stress=0

echo "{\"labels\": {\"hostname\": \"${HUB_PORT_4444_TCP_ADDR}\"}, \"results\": {\"node_count\": ${selenium_hub_nodecount_total}, \"stress\": ${selenium_hub_stress}, \"slots_busy\": ${selenium_hub_slotcount_inuse}, \"slots_free\": ${selenium_hub_slotcount_free}, \"slots_total\": ${selenium_hub_slotcount_total}, \"slots_pending\": ${newSessionRequestCount}} }"

exit 0