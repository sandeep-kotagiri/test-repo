namespace: Integrations.DataProtector
flow:
  name: VM_BACKUP
  inputs:
    - data_protector_url: 'http://sandeep-dp.ftc.hpeswlab.net:8080/dataprotector/'
    - vm_id: VMdd82ce
    - datacenter: FTC
    - vcenter_host: 10.12.181.45
  workflow:
    - invoke_backup_api:
        do:
          io.cloudslang.base.http.http_client_post:
            - url: "${data_protector_url + '/vm-backup'}"
            - headers: '${Accept:application/json}'
            - body: "${'{\"virtualMachine\":\"' +vm_id+ '\", \"virtualMachineDataCenter\":\"'+datacenter+'\", \"vcenter\":\"'+vcenter_host+'\"}'}"
            - content_type: '${application/json}'
        publish:
          - vm_backup_json: '${return_result}'
        navigate:
          - SUCCESS: extract_backup_id
          - FAILURE: on_failure
    - extract_backup_id:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${vm_backup_json}'
            - json_path: $.backupSessionId
        publish:
          - vm_backup_id: '${return_result}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - vm_backup_id: '${vm_backup_id}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      invoke_backup_api:
        x: 202
        y: 115
      extract_backup_id:
        x: 366
        y: 116
        navigate:
          5accac0c-dbd0-b9df-5172-2594201e23f4:
            targetId: 30ffaeed-0490-2c18-e2cd-2a03394f26b7
            port: SUCCESS
    results:
      SUCCESS:
        30ffaeed-0490-2c18-e2cd-2a03394f26b7:
          x: 543
          y: 118
