## AtlaZ - Input

These are the sorts of data inputs expected by AtlaZ. Note however, this is incomplete and preliminary. It will be further developed as the project progresses based on what's possible in the time constraint.

### Neuroanatomical Data

- **File Type:** CSV/TSV or similar.
- **Contents:** Identifiers for brain regions, descriptions, and possibly coordinates for spatial mapping.
- **Example Structure:**
   - `RegionID`: Unique identifier for a neuroanatomical region.
   - `RegionName`: The name of the brain region.
   - `Coordinates`: X, Y, Z coordinates for 3D mapping (if applicable).
   - `DevelopmentalStage`: Timepoint or stage of development.

### Gene Expression Data

- **File Type:** CSV/TSV or output from specific bioinformatics tools.
- **Contents:** Gene identifiers, expression levels (often normalized), and experimental conditions.
- **Example Structure:**
   - `GeneID`: Unique identifier for a gene (e.g., Ensembl ID).
   - `ExpressionLevel`: Normalized expression value (e.g., TPM, FPKM, or counts).
   - `Condition`: Experimental condition or treatment group.
   - `TimePoint`: When the sample was collected during the experiment.
   - `Replicate`: Identifier for replicate samples.

### Behavioural Assay Data

- **File Type:** CSV/TSV or proprietary formats from behavioural tracking software.
- **Contents:** Timestamps, behavioural descriptors, possibly linked to video data.
- **Example Structure:**
   - `Time`: Timestamp of the observed behaviour.
   - `behaviour`: Description or code representing the observed behaviour.
   - `Duration`: Length of time the behaviour was observed.
   - `Stimulus`: Information about any stimuli presented (e.g., light, sound).
   - `SubjectID`: Identifier for the individual zebrafish.
 - **Note:**
   - Behavioural data can also be in the form of x/y coordinates of the fish over time in comparison to the coordinates of the stimulus. This is useful for tracking the movement of the fish in response to a stimulus.