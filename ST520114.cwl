#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT5204: Directory
  DT5208: Directory
  DT5210: Directory

outputs:
  DT5208:
    type: Directory
    outputSource: DT5208

steps:
  SS5214:
    in:
      DT5204: DT5204
      DT5208: DT5208
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5204: Directory
        DT5208: Directory
        DT5210: Directory
      outputs:
        DT5201: Directory
        DT5209: Directory
    out:
    - DT5201
    - DT5209
