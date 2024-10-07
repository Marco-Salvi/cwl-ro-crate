#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT5208: Directory
  DT5209: Directory
  DT5210: Directory

outputs:
  DT5209:
    type: Directory
    outputSource: DT5209

steps:
  SS5215:
    in:
      DT5208: DT5208
      DT5209: DT5209
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5208: Directory
        DT5209: Directory
        DT5210: Directory
      outputs:
        DT5201: Directory
    out:
    - DT5201
