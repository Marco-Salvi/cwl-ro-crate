cwlVersion: v1.2
class: Workflow
inputs:
    DT5210: Directory
outputs:
    DT5205:
        type: Directory
        outputSource: SS5209/DT5205
steps:
    SS5209:
        run:
            class: Operation
            inputs: {}
            outputs:
                DT5201: Directory
                DT5205: Directory
        in: {}
        out:
            - DT5201
            - DT5205
