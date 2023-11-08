## Functions

### animateMovement

This function creates an animation of the movement paths of both the fish and the stimulus over time. It plots the x and y coordinates of the fish and the stimulus, showing how the fish responds to the stimulus.

#### Parameters

- `behaviourData`: A dataframe with columns: xFish, yFish, xStim, yStim, time.
- `filename`: The name of the file where the animation will be saved.

#### Return

Saves the animation to a file.

#### Example

```r
animateMovement(behaviourData, "animation.gif")
```

### generateData

This function generates a sample data frame representing the movement of a fish and a stimulus over time. The stimulus moves in a circle, while the fish moves randomly.

#### Parameters

- `time`: The total time for which to generate data.
- `step`: The time step between each data point.

#### Return

A data frame with columns: time, xFish, yFish, xStim, yStim.

#### Example

```r
generateData(10, 0.1)
```

### heatmapActivity

This function generates a heatmap representing the frequency of the fish's positions, indicating areas of high and low activity. It requires the `ggplot2` library to create a 2D binning heatmap.

#### Parameters

- `behaviourData`: A dataframe with columns: xFish, yFish.

#### Return

A heatmap of fish activity.

#### Example

```r
heatmapActivity(behaviourData)
```

### importBehaviouralData

This function imports behavioural assay data from a specified file path, expecting a tab-delimited format. It ensures that the file exists and is readable prior to importing the data.

#### Parameters

- `filepath`: A string representing the path to the behavioural assay data file.

#### Return

A `data.frame` containing behavioural assay data.

#### Example

```r
behaviour_data <- importBehaviouralData("inst/extdata/behavioural_data.csv")
```

### importGeneExpressionData

This function imports gene expression data from a file path provided. The expected format is tab-delimited. It performs checks to ensure the file exists and can be read before loading the data.

#### Parameters

- `filepath`: A string representing the path to the gene expression data file.

#### Return

A `data.frame` containing gene expression data.

#### Example

```r
gene_data <- importGeneExpressionData("inst/extdata/expression_data.txt")
```

### importNeuroData

This function reads and imports neuroanatomical data from a specified file path. The data should be tab-delimited. This function checks for file existence and readability before attempting to read the file.

#### Parameters

- `filepath`: A string representing the path to the neuroanatomical data file.

#### Return

A `data.frame` containing neuroanatomical data with appropriate headers.

#### Example

```r
neuro_data <- importNeuroData("inst/extdata/neuroanatomical_data.tsv")
```

### plotDistanceOverTime

This function calculates and plots the distance between the fish and the stimulus over time, providing insight into the fish's response to the stimulus.

#### Parameters

- `behaviourData`: A dataframe with columns: xFish, yFish, xStim, yStim, time.

#### Return

A plot showing the distance of the fish from the stimulus over time.

#### Example

```r
plotDistanceOverTime(behaviourData)
```