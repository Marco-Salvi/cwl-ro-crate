cwlVersion: v1.2
class: Workflow
inputs:
    DT5210: Directory
outputs:
    DT5207:
        type: Directory
        outputSource: SS5211/DT5207
steps:
    SS5211:
        run:
            class: Operation
            inputs: {}
            outputs:
                DT5201: Directory
                DT5207: Directory
        in: {}
        out:
            - DT5201
            - DT5207
