*IBM Documentation*: 

- https://www.ibm.com/docs/en/cloud-paks/cp-biz-automation/24.0.0?topic=deployment-quick-reference-qa-offline-deployments
- https://www.ibm.com/docs/en/cloud-paks/cp-biz-automation/24.0.0?topic=icmppd-option-2-preparing-your-cluster-air-gapped-offline-deployment
- https://www.ibm.com/docs/en/cloud-paks/cp-biz-automation/24.0.0?topic=deployment-mirroring-catalogs-private-registry-using-oc-mirror

*Prerequisites*:
- Install git.
- Install podman.

Scripts take case.env file as first argument. Make a copy of case file cloudpak / version combination.<br/>
Update `case.env` `CASE_VERSION` and `CASE_BRANCH` values as needed.<br/>
Depending on the cloudpak, set `MIRROR_TOOLS` to `oc-mirror` or `oc-image-mirror`.<br/>

For cloudpak for Business Automation, set `MIRROR_TOOLS=oc-mirror`.<br/>
For other cloudpaks, consult documentation.<br/>

Update `registry.env` file with private registry location.<br/>

*Steps:*<br/>
`0*` scripts install required cli binaries in the `./bin` directory.<br/>
```
0-1-install-oc.sh
0-2-install-oc-mirror.sh
0-3-install-pak-plugin.sh case.env
0-4-config-ibm-pak.sh case.env
0-5-ibm-pak-show-config.sh case.env
```

Authenticate to registries.<br/>
Log into cloud pak repo: (password is ibm entitlement key)<br/>
`podman login cp.icr.io -u cp`

Log into your private registry:<br/>
`podman login my.private.registry -u myuser`

For Cloud Pak for Business Automation, run:<br/>
```
1-clone-cert-kubernetes.sh case.env
```

Download case files.<br/>
To download case files for Cloud Pak for Business Automation:<br/>
```
2-download-case-files-cp4ba.sh case.env
```
To download case files for other cloudpaks:<br/>
```
2-download-case-files.sh case.env
```
List downloaded cases:<br/>
```
2-1-list-downloaded-cases.sh case.env
```

Generate mirror manifests.<br/>
To mirror cloudpak container images to a file and then upload this file to a private registry:<br/>
```
3-generate-mirror-manifests.sh case.env tofile
```
To mirror cloudpak container images directly to private registry:<br/>
```
3-generate-mirror-manifests.sh case.env
```
If `MIRROR_TOOLS` is set to `oc-mirror`:<br/>
Remove channels that you do not want from `${IBMPAK_HOME}/.ibm-pak/data/mirror/${CASE_NAME}/${CASE_VERSION}/image-set-config.yaml`<br/>

Mirror and upload images.<br/>
To mirror cloudpak container images to a file and then upload this file to a private registry:<br/>
```
4-mirror-oc-mirror.sh case.env tofile
4-mirror-oc-mirror.sh case.env fromfile [mirror sequence file, default: mirror_seq1_000000.tar]
```

To mirror cloudpak container images directly to private registry:<br/>
```
4-mirror-images.sh case.env
```
Mirror Fusion Data Foundation images.<br/>

Update `OCP_VERSION` and `OCP_FULL_VERSION` values in `fdf-290.env`.<br/>

Generate `imageset config` and `image digest mirror set`.<br/>
Pass `rhcat` as second argument if you want to include redhat fusion catalog.<br/>
```
fdf-imageset-config.sh ./fdf-290.env [rhcat]
```

Mirror Fusion Data Foundation images.<br/>
```
4-mirror-images.sh ./fdf-290.env
```

