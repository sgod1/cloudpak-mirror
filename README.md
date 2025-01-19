*IBM Documentation*: 

- https://www.ibm.com/docs/en/cloud-paks/cp-biz-automation/24.0.0?topic=deployment-quick-reference-qa-offline-deployments
- https://www.ibm.com/docs/en/cloud-paks/cp-biz-automation/24.0.0?topic=icmppd-option-2-preparing-your-cluster-air-gapped-offline-deployment
- https://www.ibm.com/docs/en/cloud-paks/cp-biz-automation/24.0.0?topic=deployment-mirroring-catalogs-private-registry-using-oc-mirror

*Prerequisites*:
- Install git.
- Install podman.

*Steps:*<br/>
Update `case.env` `CASE_VERSION` and `CASE_BRANCH` values as needed.<br/>

Run scripts in order from the current directory.<br/>

`0*` scripts install required cli binaries in the `./bin` directory.<br/>

Log into cloud pak repo: (password is ibm entitlement key)<br/>
`podman login cp.icr.io -u cp`

Log into your private registry:<br/>
`podman login my.private.registry -u myuser`

Update `registry.env` file with your private registry and location of your auth file.<br/>
