#' Meshing tools
#' 
#' A toolbox for meshing operations: elastic mesh mapping, Iteratively closest point matching, vertex selection, ...,
#' 
#' \tabular{ll}{
#' Package: \tab mesheR\cr
#' Type: \tab Package\cr
#' Version: \tab 0.4.131107\cr
#' Date: \tab 2013-11-07\cr
#' License: \tab GPL\cr
#' LazyLoad: \tab yes\cr }
#' 
#' @name mesheR-package
#' @aliases mesheR-package mesheR
#' @docType package
#' @author Stefan Schlager
#' 
#' Maintainer: Stefan Schlager <zarquon42@@gmail.com>
#' @references To be announced
#' @keywords package
#' @useDynLib mesheR
#' @importClassesFrom spam spam spam.chol.NgPeyton
#' @importFrom Morpho adnormals angle.calc closemeshKD conv2backf facenormals file2mesh mcNNindex meshcube meshDist meshres projRead rmUnrefVertex rmVertex rotmesh.onto rotonmat rotonto tanplan tps3d unrefVertex vert2points warp.mesh
#' @importFrom Rvcg vcgBorder vcgClost vcgGetEdge vcgRaySearch vcgNonBorderEdge vcgSmooth 
#' @importFrom parallel detectCores mclapply
#' 

NULL