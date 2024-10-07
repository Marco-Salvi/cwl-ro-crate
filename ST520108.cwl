cwlVersion: v1.2
class: Workflow
inputs:
    DT5210: Directory
outputs: {}
steps:
    SS5208:
        run:
            class: Operation
            inputs: {}
            outputs:
                DT5201: Directory
        in: {}
        out:
            - DT5201
