library(AtlaZ)

# Test case 1: Single gene symbol
test_that("getGeneInfo works with a single gene symbol", {
    geneSymbols <- c("raraa")

    # Omit ontology data from expected output because it is very long. Instead
    # check that the ontology slot is an OntologyList object with at least one
    # ontology.
    expectedOutput <- list(
        raraa = new("Gene",
            geneSymbol = "raraa",
            ensemblID = "ENSDARG00000056783",
            zfinID = "ZDB-GENE-980526-284",
            ontology = new("OntologyList")
        )
    )
    actualOutput <- getGeneInfo(geneSymbols)
    expect_identical(
        expectedOutput$raraa@geneSymbol,
        actualOutput$raraa@geneSymbol
    )
    expect_identical(
        expectedOutput$raraa@ensemblID,
        actualOutput$raraa@ensemblID
    )
    expect_identical(
        expectedOutput$raraa@zfinID,
        actualOutput$raraa@zfinID
    )
    expect_is(actualOutput$raraa@ontology, "OntologyList")
    expect_gt(length(actualOutput$raraa@ontology@ontologies), 0)
})

# Test case 2: Multiple gene symbols
test_that("getGeneInfo works with multiple gene symbols", {
    geneSymbols <- c("raraa", "rargb")
    expectedOutput <- list(
        raraa = new("Gene",
            geneSymbol = "raraa",
            ensemblID = "ENSDARG00000056783",
            zfinID = "ZDB-GENE-980526-284",
            ontology = new("OntologyList")
        ),
        rargb = new("Gene",
            geneSymbol = "rargb",
            ensemblID = "ENSDARG00000054003",
            zfinID = "ZDB-GENE-070314-1",
            ontology = new("OntologyList")
        )
    )
    actualOutput <- getGeneInfo(geneSymbols)
    expect_identical(
        expectedOutput$raraa@geneSymbol,
        actualOutput$raraa@geneSymbol
    )
    expect_identical(
        expectedOutput$raraa@ensemblID,
        actualOutput$raraa@ensemblID
    )
    expect_identical(
        expectedOutput$raraa@zfinID,
        actualOutput$raraa@zfinID
    )
    expect_is(actualOutput$raraa@ontology, "OntologyList")
    expect_gt(length(actualOutput$raraa@ontology@ontologies), 0)

    expect_identical(
        expectedOutput$rargb@geneSymbol,
        actualOutput$rargb@geneSymbol
    )
    expect_identical(
        expectedOutput$rargb@ensemblID,
        actualOutput$rargb@ensemblID
    )
    expect_identical(
        expectedOutput$rargb@zfinID,
        actualOutput$rargb@zfinID
    )
    expect_is(actualOutput$rargb@ontology, "OntologyList")
    expect_gt(length(actualOutput$rargb@ontology@ontologies), 0)
})

# Test case 3: Empty gene symbols
test_that("getGeneInfo works with empty gene symbols", {
    geneSymbols <- character(0)
    expectedOutput <- list()
    actualOutput <- getGeneInfo(geneSymbols)
    expect_identical(expectedOutput, actualOutput)
})

# Test case 4: Invalid gene symbol
test_that("getGeneInfo returns an empty list with invalid gene symbol", {
    geneSymbols <- c("invalid")
    expectedOutput <- list()
    actualOutput <- getGeneInfo(geneSymbols)
    expect_identical(expectedOutput, actualOutput)
})

# Test case 5: Non-character gene symbols
test_that("getGeneInfo throws an error with non-character gene symbols", {
    geneSymbols <- c(1)
    expect_error(getGeneInfo(geneSymbols))
})

# Test case 6: Missing gene symbols
test_that("getGeneInfo throws an error with missing gene symbols", {
    expect_error(getGeneInfo())
})