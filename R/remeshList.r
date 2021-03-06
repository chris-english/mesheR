#' Remesh a list of registered meshes (with corresponding vertices)
#'
#' Remesh a list of registered meshes (with corresponding vertices), preserving correspondences using Quadric Edge Collapse decimation
#' @param matchlist a list of meshes with corresponding vertices (same amount and pseudo-homologous positions), e.g. registered with \code{\link{gaussMatch}}. Meshes do not need to be aligned.
#' @param reference integer: select the specimen the to which the decimation is to applied initially.
#' @param random if TRUE, a random specimen is selected for initial decimation
#' @param voxelSize voxel size for space discretization
#' @param discretize If TRUE, the position of the intersected edge of the marching cube grid is not computed by linear interpolation, but it is placed in fixed middle position. As a consequence the resampled object will look severely aliased by a stairstep appearance.
#' @param multiSample If TRUE, the distance field is more accurately compute by multisampling the volume (7 sample for each voxel). Much slower but less artifacts.
#' @param absDist If TRUE, an unsigned distance field is computed. In this case you have to choose a not zero Offset and a double surface is built around the original surface, inside and outside.
#' @param mergeClost logical: merge close vertices
#' @param silent logical: suppress messages
#' 
#' @return a list of remeshed meshes with correspondences preserved.
#' @details The remeshing is applied to a reference and then the barycentric coordinates of the new vertices on the original surface are calculated. These are used to extract the corresponding positions of the remeshed versions on all meshes in the sample. The remeshing is performed by the function \code{vcgUniformRemesh} from the Rvcg-package.
#' @importFrom Rvcg vcgUniformRemesh
#' @export
remeshList <- function(matchlist,reference=1,random=FALSE,voxelSize = NULL, discretize = FALSE, multiSample = FALSE, absDist = FALSE, mergeClost = FALSE,  silent = FALSE) {
    if (! random)
        reference <- sample(length(matchlist),size=1)

    ref <- matchlist[[reference]]
    remref <- vcgUniformRemesh(ref,voxelSize = voxelSize, discretize = discretize, multiSample = multiSample, absDist = absDist, mergeClost = mergeClost,  silent = silent)
    bary <- vcgClostKD(remref,ref,barycentric=T)

    outlist <- list()
    for (i in 1:length(matchlist)) {
        tmp <- remref
        tmpvert <- bary2point(bary$barycoords,bary$faceptr,matchlist[[i]])
        tmp$vb[1:3,] <- t(tmpvert)
        tmp <- vcgUpdateNormals(tmp)
        outlist[[i]] <- tmp
    }
    names(outlist) <- names(matchlist)
    return(outlist)
}
#' decimate a list of registered meshes (with corresponding vertices)
#'
#' decimate a list of registered meshes (with corresponding vertices), preserving correspondences using Quadric Edge Collapse decimation
#'
#' @param matchlist a list of meshes with corresponding vertices (same amount and pseudo-homologous positions), e.g. registered with \code{\link{gaussMatch}}. Meshes do not need to be aligned.
#' @param reference integer: select the specimen the to which the decimation is to applied initially.
#' @param random if TRUE, a random specimen is selected for initial decimation
#' @param ... parameters passed to vcgQEdecim
#' @return a list of decimated meshes with correspondences preserved.
#' @details The decimation is applied to a reference and then the barycentric coordinates of the new vertices on the original surface are calculated. These are used to extract the corresponding positions of the remeshed versions on all meshes in the sample. The Decimation is performed by the function \code{vcgQEdecim} from the Rvcg-package.
#' @importFrom Rvcg vcgQEdecim
#' @export
decimateList <- function(matchlist,reference=1,random=FALSE, ...)  {

    if ((random))
        reference <- sample(length(matchlist),size=1)

    ref <- matchlist[[reference]]
    remref <- vcgQEdecim(ref,...)
    bary <- vcgClostKD(remref,ref,barycentric=T)

    outlist <- list()
    for (i in 1:length(matchlist)) {
        tmp <- remref
        tmpvert <- bary2point(bary$barycoords,bary$faceptr,matchlist[[i]])
        tmp$vb[1:3,] <- t(tmpvert)
        tmp <- vcgUpdateNormals(tmp)
        outlist[[i]] <- tmp
    }
    names(outlist) <- names(matchlist)
    return(outlist)
}
