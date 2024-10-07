#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT5205: Directory
  DT5206: Directory
  DT5207: Directory

outputs: {}

steps:
  SS5212:
    in:
      DT5205: DT5205
      DT5206: DT5206
      DT5207: DT5207
    run:
      class: Operation
      inputs:
        DT5205: Directory
        DT5206: Directory
        DT5207: Directory
      outputs:
        DT5201: Directory
        DT52011: Directory
    out:
    - DT5201
    - DT52011
