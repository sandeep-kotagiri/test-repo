namespace: CSA-CONTENT-PACK.PROVIDERS.DATAPROTECTOR.ACTIONS
flow:
  name: BACKUP_VM
  inputs:
    - vm_id: VMdd82ce
    - vcenter_host: 10.12.181.45
    - datacenter: FTC
    - data_protector_url: 'http://sandeep-dp.ftc.hpeswlab.net:8080/dataprotector/'
  workflow:
    - http_client_post:
        do:
          io.cloudslang.base.http.http_client_post:
            - url: "${data_protector_url + '/vm-backup'}"
            - headers: 'Accept:application/json'
            - body: "${'{\"virtualMachine\":\"' +vm_id+ '\", \"virtualMachineDataCenter\":\"'+datacenter+'\", \"vcenter\":\"'+vcenter_host+'\"}'}"
            - content_type: application/json
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      http_client_post:
        x: 145
        y: 103
        navigate:
          fa8e0568-52c2-6f3a-7a10-83da25636552:
            targetId: d17197ab-8c0a-6f5b-3b4c-6556388eb201
            port: SUCCESS
    results:
      SUCCESS:
        d17197ab-8c0a-6f5b-3b4c-6556388eb201:
          x: 300
          y: 98
