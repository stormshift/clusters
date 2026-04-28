Workload Availability for the ISAR Cluster on Stormshift.
Adds:
- node health check operator NHC
- fencing remediation operator FAR

And the necessary CR to configure fencing correctly.

IMPORT:
If a node is shutdown for planned maintenance for a longer period of time,
the label
remediation.medik8s.io/exclude-from-remediation: true
should be added to avoid the node being started by FenceAgentsRemediationTemplate


Documentation:
https://docs.redhat.com/en/documentation/workload_availability_for_red_hat_openshift/
