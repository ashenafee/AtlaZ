#' Baseline Gene Expression Across Developmental Stages
#'
#' A subset of the expression values across all genes across different stages of
#' zebrafish development. The subset consists of the first 100 rows of the
#' original dataset (which contains 24096 rows).
#'
#' @source The dataset is available from EMBL-EBI's Expression Atlas. It was put
#' together by the Zebrafish Model Organism Database (ZFIN) and is available
#' @format A data frame with 100 rows and 26 columns:
#' \describe{
#'  \item{Gene ID}{The gene ID.}
#'  \item{Gene Name}{The gene name.}
#'  \item{zygote}{The expression value at the zygote stage.}
#'  \item{cleavage 2-cell}{The expression value at the cleavage 2-cell stage.}
#'  \item{blastula 128-cell}{The expression value at the blastula 128-cell
#'  stage.}
#'  \item{blastula 1k-cell}{The expression value at the blastula 1k-cell stage.}
#'  \item{blastula dome}{The expression value at the blastula dome stage.}
#'  \item{gastrula 50\%-epiboly}{The expression value at the gastrula 50%-epiboly
#'  stage.}
#'  \item{gastrula shield}{The expression value at the gastrula shield stage.}
#'  \item{gastrula 75\%-epiboly}{The expression value at the gastrula 75%-epiboly
#'  stage.}
#'  \item{segmentation 1-4 somites}{The expression value at the segmentation 1-4
#'  somites stage.}
#'  \item{segmentation 14-19 somites}{The expression value at the segmentation
#'  14-19 somites stage.}
#'  \item{segmentation 20-25 somites}{The expression value at the segmentation
#'  20-25 somites stage.}
#'  \item{pharyngula prim-5}{The expression value at the pharyngula prim-5
#'  stage.}
#'  \item{pharyngula prim-15}{The expression value at the pharyngula prim-15
#'  stage.}
#'  \item{pharyngula prim-25}{The expression value at the pharyngula prim-25
#'  stage.}
#'  \item{hatching long-pec}{The expression value at the hatching long-pec
#'  stage.}
#'  \item{larval protruding mouth}{The expression value at the larval protruding
#'  mouth stage.}
#'  \item{larval day 4}{The expression value at the larval day 4 stage.}
#'  \item{larval day 5}{The expression value at the larval day 5 stage.}
#' }
#' @examples
#' \dontrun{
#' baselineExp
#' }
"baselineExp"

# [END]
