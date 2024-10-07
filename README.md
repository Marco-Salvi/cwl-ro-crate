# CWL + RO-Crate Workflow Description

## Overview

This document describes our solution to representing workflows using **Common Workflow Language (CWL)** and **Research Object Crate (RO-Crate)**. We use CWL to define and describe the computational steps and data flow, while RO-Crate captures the associated metadata for the workflow, datasets, tools, and software.

## CWL ([Common Workflow Language](https://www.commonwl.org/))
CWL is a standard format used to describe computational workflows in a portable and scalable way. It allows us to define the steps, inputs, outputs, and tools involved in a workflow, creating a clear structure that can be understood and executed by various CWL-compatible tools.

## RO-Crate ([Research Object Crate](https://www.researchobject.org/ro-crate/))
RO-Crate is a standard for packaging research data and metadata. It allows us to associate the contents of a workflow repository (e.g., CWL files, datasets, tools) with rich metadata, providing contextual information about the workflow's structure and purpose.

## Our Approach

We represent workflows using a combination of **CWL** and **RO-Crate**:
- **CWL**: Defines the specifics of the workflow, such as steps, data flow, and tools.
- **RO-Crate**: Describes the metadata of the workflow, including information about the workflow itself, the datasets used, and the tools employed.

By using both CWL and RO-Crate (which are already widely adopted in the workflow community), we can leverage existing tools for workflow visualization, editing, and validation.

[Example of a visualization](https://view.commonwl.org/workflows/github.com/Marco-Salvi/cwl-ro-crate/blob/main/WF5201.cwl)

---

## Example: DTC52 Workflow

### Workflow Components
An example of our CWL + RO-Crate workflow includes the following files:

```
ST520101.cwl
ST520102.cwl
ST520103.cwl
...
WF5201.cwl
ro-crate-metadata.json
```

- **`.cwl` files**: These describe individual workflow steps or sub-workflows.
- **`WF5201.cwl`**: The top-level workflow that describes the main structure.
- **`ST520---.cwl`**: A step of the top level workflow, also represented as a workflow.
- **`ro-crate-metadata.json`**: The RO-Crate metadata file that contains descriptions of all workflow components, including files and datasets.

### Top-Level Workflow (WF5201.cwl)

Example of a CWL top-level workflow file (`WF5201.cwl`):

```yaml
cwlVersion: v1.2
class: Workflow
inputs:
    DT5210: Directory
outputs:
    DT5202:
        type: Directory
        outputSource: ST520104/DT5202
    DT5203:
        type: Directory
        outputSource: ST520105/DT5203

requirements:
    SubworkflowFeatureRequirement: {}
steps:
    ST520104:
        run: ST520104.cwl
        in:
            DT5210: DT5210
        out:
            - DT5202
    ST520105:
        run: ST520105.cwl
        in:
            DT5210: DT5210
        out:
            - DT5203
```

In this workflow:
- **Inputs** and **outputs** are declared globally at the start. 
- **Subworkflows** are enabled, allowing each step to be a sub-workflow.
- Each **step** is defined, specifying the inputs, outputs, and the CWL file that describes the step's logic.

### Workflow Structure as a [Directed Acyclic Graph](https://en.wikipedia.org/wiki/Directed_acyclic_graph#:~:text=A%20directed%20acyclic%20graph%20is,a%20path%20with%20zero%20edges) (DAG)

CWL treats workflows as **Directed Acyclic Graphs (DAGs)**, where:
- Each step is a **node** in the graph.
- Each data dependency between steps is represented as an **edge** or arc.
- The workflow's execution order is inferred based on these dependencies, rather than being explicitly stated.

This approach allows for more flexibility, as the order of steps can be deduced automatically from the flow of data.

### Example of a Sub-workflow (ST520101.cwl)

A sub-workflow file (`ST520101.cwl`) follows a similar structure:

```yaml
SS5204:
    run:
        class: Operation
        inputs:
            DT52010: Directory
        outputs:
            DT5201: Directory
            DT5202: Directory
    in:
        DT52010: DT52010
    out:
        - DT5201
        - DT5202
SS5205:
    run:
        class: Operation
        inputs:
            DT52010: Directory
        outputs:
            DT5201: Directory
            DT5203: Directory
    in:
        DT52010: DT52010
    out:
        - DT5201
        - DT5203
```

Each step defines its inputs, outputs, and the class of operation it performs. This is done in a consistent manner across all sub-workflows.

---

## Conversion from Spreadsheet Representation

In transitioning from the spreadsheet-based workflow representation to CWL + RO-Crate, several key issues must be addressed:

### 1. Versioning of Updated Datasets

During workflow execution, some datasets may be updated, altering their content. However, in the spreadsheet-based representation, there is no tracking of which specific version of the updated dataset is used at each step.

To address this, we could implement a dataset versioning strategy, where each updated dataset is assigned a new version identifier. Several approaches can be considered:

- **Semantic-free versioning**: The updated dataset receives a new, arbitrary identifier. In this case, additional metadata is required to capture the version’s origin, its relationship to previous versions, and how it was generated.
  
- **Semantic-rich versioning**: The updated dataset’s identifier encodes information about:
  - The temporal relationship between the new and old versions.
  - The process by which the new version was derived from the previous one.
  
- **Hybrid approach**: The dataset ID contains meaningful information about both its version and its provenance, reducing the need for additional metadata while maintaining clarity about dataset lineage.


### 2. Cyclic Dependencies
CWL workflows are modeled as **Acyclic Directed Graphs**, meaning that cycles (where a step depends on itself, directly or indirectly) are not allowed. In the spreadsheets, some cyclic dependencies appear, likely due to:
- Possible errors in the description
- Usage of updated dataset using the original dataset's name

These cycles must be corrected before the workflow can be properly represented in CWL.

### 3. "Useless" Steps
Some steps in the spreadsheets consist only of manually gathering data, which could be simplified:
- These steps can be removed and replaced by global CWL inputs.
- Some steps lack inputs, outputs, or both, indicating potential errors in the spreadsheet that should be addressed before conversion.

---

## Key Spreadsheet Tables for Conversion

The following tables are crucial for converting the spreadsheet into CWL:

- **ST-WF**: Maps which steps (ST) are used in which workflows (WF).
- **SS-ST**: Describes which software or service (SS) is used in each sub-workflow (ST).
- **DT-SS**: Defines dependencies between datasets (DT) and steps (SS) in a sub-workflow.
- **DT-ST**: Captures dependencies between datasets and steps in the top-level workflow.

Any errors or inconsistencies in these tables must be resolved to ensure a valid CWL representation.

For the `ro-crate-metadata.json` file, it is essential to have as much information as possible about the workflows, steps, datasets, and services. 
