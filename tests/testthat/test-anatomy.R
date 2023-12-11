library(AtlaZ)

test_that("Anatomy class can be created correctly", {
    # Create a new Anatomy object
    anatomy <- new(
        "Anatomy",
        id = "A1",
        label = "Label1",
        description = "Description1"
    )

    # Check that the slots are correctly set
    expect_equal(anatomy@id, "A1")
    expect_equal(anatomy@label, "Label1")
    expect_equal(anatomy@description, "Description1")
})