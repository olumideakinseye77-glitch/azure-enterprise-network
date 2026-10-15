# Troubleshooting Evidence

## Scenario: App Spoke could not reach Data Spoke on TCP 443

### Expected behaviour

The application test VM at `10.20.1.4` should reach the data test VM at `10.30.2.4` on TCP 443. The data VM was confirmed to be listening on port 443.

### Observed behaviour

A TCP test from the App Spoke timed out.

Azure Network Watcher Connection Troubleshoot then reported:

- Connection status: `Unreachable`
- `UserDefinedRoute`: `NextHop Type None`
- `NetworkSecurityRule`: `DefaultRule_DenyAllOutBound`
- 30 probes sent, 30 failed

### Root cause

Hub-and-spoke VNet peering is non-transitive. Both spokes were connected to the Hub, but no forwarding appliance and no user-defined routes existed to carry traffic between the two spokes. The App NSG also had no explicit outbound rule for the Data subnet.

### Remediation

The Terraform configuration was extended with:

1. A Linux NVA in the Hub shared subnet with NIC IP forwarding enabled.
2. Kernel IPv4 forwarding enabled on the NVA.
3. An App route table directing `10.30.0.0/16` to the NVA.
4. A Data route table directing `10.20.0.0/16` to the NVA.
5. Explicit App outbound TCP 443 permission to the Data subnet.
6. Existing Data inbound TCP 443 permission retained.

### Validation

After deployment, rerun Network Watcher Connection Troubleshoot and direct TCP tests to prove TCP 443 is reachable while non-approved ports remain blocked.


## Final validation

After the routing remediation was deployed:

- Network Watcher reported TCP 443 as `Reachable`.
- The path traversed the Hub NVA at `10.10.1.4`.
- All 66 probes to TCP 443 succeeded.
- TCP 8080 was intentionally tested and blocked.
- Network Watcher identified the explicit `Deny-Other-App-To-Data` NSG rule on the Data subnet.
- This confirmed both the UDR/NVA routing path and least-privilege NSG enforcement were working as designed.
