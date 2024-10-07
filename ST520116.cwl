cwlVersion: v1.2
class: Workflow
inputs:
    DT5208: Directory
outputs:
    DT5209:
        type: Directory
        outputSource: ST520116/DT5209
steps:
    ST520116:
        run:
            class: Operation
            inputs:
                DT5208: Directory
            outputs:
                DT5209: Directory
        in:
            DT5208: DT5208
        out:
            - DT5209
