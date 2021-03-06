% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gaussDisplace.r
\name{gaussMatch}
\alias{gaussMatch}
\title{map two surface meshes using smoothed displacement fields}
\usage{
gaussMatch(x, mesh2, iterations = 10, smooth = NULL, smoothit = 10,
  smoothtype = c("taubin", "laplace", "HClaplace"), sigma = 20,
  displacementsmooth = c("Gauss", "Laplace", "Exponential"), gamma = 2,
  f = 1.2, oneway = F, lm1 = NULL, lm2 = NULL, rigid = NULL,
  similarity = NULL, affine = NULL, tps = FALSE, nh = NULL,
  toldist = 0, pro = c("kd", "vcg", "morpho"), k0 = 50,
  prometh = 1, angtol = pi/2, border = FALSE, horiz.disp = NULL,
  useiter = FALSE, AmbergK = NULL, AmbergLambda = NULL,
  tol = 1e-05, useConstrained = TRUE, angclost = TRUE,
  noinc = FALSE, silent = FALSE, visualize = FALSE, folder = NULL,
  alpha = 0.7, col1 = "red", col2 = "white", add = FALSE,
  bbox = NULL, bboxCrop = NULL, threads = 0, cb = NULL, ...)
}
\arguments{
\item{x}{reference mesh: triangular mesh of class "mesh3d"or of class BayesDeform created by createBayes to restrict based on a known distribution. To use this option the package RvtkStatismo \url{https://github.com/zarquon42b/RvtkStatismo} has to be installed. If x is a model, it works best if mesh2 is already aligned to the model's mean.}

\item{mesh2}{An object of class mesh3d used as target mesh. Mesh resolution
should be ~1.5.}

\item{iterations}{Iterations of displacement. Default is 10.}

\item{smooth}{Integer: smooth the resulting mesh at the \code{smooth-th} iteration. E.g. a value of 2 will smooth the resulting mesh at each 2nd iteration. Not to be confused with \code{displacementsmooth}!! Default is NULL, no smoothing.}

\item{smoothit}{integer: smoothing steps.}

\item{smoothtype}{Type of smoothing: Taubin, Laplacian, or HClaplacian. For
details see \code{vcgSmooth}.}

\item{sigma}{starting value of kernel bandwidth/B-spline support. For all kernels except B-spline, sigma controls the importance of the neighbourhood by defining the bandwidth of the smoothing kernel. For B-spline it defines the support (the higher, the "wobblier" the deformation field can become.}

\item{displacementsmooth}{kernel function for smoothing are "Gauss","Laplace", "Exponential" and "Bspline" (or any abbreviation thereof).}

\item{gamma}{dampening factor controlling displacement strength. The smoothed displacement vector for each vertex is divided by \code{gamma}. The larger \code{gamma}, the slower the approximation.}

\item{f}{parameter controlling iterative decrease (if > 1, increase else) of \code{sigma} making the displacement locally more elastic with each iteration.
Starting with \code{sigma}, this parameter for the k-th iteration is \code{sigma *f ^(-k)}}

\item{oneway}{logical: only displace towards the target without taking into
account the displacement from the target.}

\item{lm1}{A k x 3 matrix containing landmarks corrresponding to mesh1 for
initial rotation of mesh1 onto mesh2.}

\item{lm2}{A k x 3 matrix containing landmarks corrresponding to mesh2 for
initial rotation of mesh1 onto mesh2.}

\item{rigid}{named list. Passing parameters to \code{\link{icp}}, for rigid registration. If landmarks are provided and only those should count, set rigid$iterations=0.}

\item{similarity}{named list. Passing parameters to \code{\link{icp}}, for similarity registration (rigid +scaling). If landmarks are provided and only those should count, set similarity$iterations=0 (and rigid=NULL).}

\item{affine}{named list. Passing parameters to \code{\link{icp}}, for affine registration. If landmarks are provided and only those should count, set similarity$iterations=0 (with rigid=NULL and similarity=NULL)}

\item{tps}{logical: if TRUE and landmarks are provided, the reference will be mapped to the target using a Thin-Plate Spline interpolation. Overrides \code{rigid},\code{affine} and \code{similarity}.}

\item{nh}{Integer: neighbourhood (number vertices) for controlling
displacement smoothing, default is 150/mesh resolution.}

\item{toldist}{Integer: Exclude everything from the whole procedure with a
greater distance from initial point than toldist. 0 disables this feature.}

\item{pro}{which projection method to use: "kd" = \code{\link{vcgClostKD}}, "m"= \code{\link{closemeshKD}}
from Morpho; "v"= \code{\link{vcgClost}} from package Rvcg.}

\item{k0}{Integer: argument passed to closemeshKD (will be argument "k" in
\code{\link{closemeshKD}} .}

\item{prometh}{argument passed to closemeshKD.  Integer: 0 or 1. If
prometh=0, take closest point for displacement. If prometh=1, do not just
take the closest point, but for two absolut distances which are the same,
take the point which is orthogonal to the closest face see Moshfeghi 1994).}

\item{angtol}{numeric: If the angle between hit points' normals and the
starting points' normals exceeds this threshold the displacement vector will
be discarded.}

\item{border}{Logical: if TRUE, displacement vectors hitting mesh borders
are discarded.}

\item{horiz.disp}{numeric: If the angle between hit points' normals
(independent of its orientation) and the distance vector between hit point
and starting points exceeds this threshold, the displacement vector will be
discarded. Reduces distortion especially at mesh borders.}

\item{useiter}{logical: if AmbergK and AmbergLambda are set and useiter is TRUE, the minimization will be performed using the latest iteration (slower). The orginal reference otherwise.}

\item{AmbergK}{a single integer or an integer vector vector containing the \code{k0}-value (normal slackness) for each iteration for a smooth Deformation using \code{\link{AmbergDeformSpam}}.}

\item{AmbergLambda}{as single numeric value or a numeric vector containing the \code{lambda}-value for each iteration for a smooth Deformation using \code{\link{AmbergDeformSpam}}.}

\item{tol}{convergence threshold: if RMSE between iterations is below tol, the function stops.}

\item{useConstrained}{logical: if TRUE and Bayes and landmarks are defined, the landmarks are not only used to get a suitable reference but the model will also be constrained by the landmarks to subsequently restrict the shape variability. If FALSE, the full model is used.}

\item{angclost}{if TRUE, the closest k faces will be evaluated and the closest with the appropriate normal angle will be selected.}

\item{noinc}{after each iteration the RMSE between target and moving image is calculated and if this value increases compared to a previous value, the matching stops. Can be useful when matching a statistical model to a partial shape.}

\item{silent}{logical suppress messages}

\item{visualize}{logical: if TRUE the matching process is visualized}

\item{folder}{character: if specified, each a screenshot of each deformation step will be saved as a png file in this folder.}

\item{alpha}{numeric between 0 and 1 controls opacity of target mesh if visualize=TRUE.}

\item{col1}{color of fix mesh (if visualize = TRUE)}

\item{col2}{color of moving mesh (if visualize = TRUE)}

\item{add}{logical: if FALSE, the 3D window will be reset.}

\item{bbox}{extend of the margins around the target shape to be considered.}

\item{bboxCrop}{extend of the bounding box around mesh1 (after alignmend) that will be cropped from target to speed things up.}

\item{threads}{integer: threads to use in multithreaded routines.}

\item{cb}{optional: callback function that takes arguments i="current iteration", distance= "distance from target to current estimate" and t.dist="average vertex displacement to last iteration"}

\item{\dots}{Further arguments passed to \code{nn2}.}
}
\value{
If a patch is specified:
 \item{mesh}{matched mesh}
 \item{patch}{displaced patch as specified in input.}
else a mesh of class "mesh3d" is returned.
}
\description{
Map a reference mesh onto a target surface using displacement fields.
}
\details{
This function implements the mesh matching method suggested by Moshfeghi et
al. and Bryan et al.. Additional mechanisms for controlling and restricting
the displacement smoothing are implemented
}
\note{
Based on the closest points (constrained by the various options), the displacement field will be smoothed using kernel functions of the k-closest displacement vectors.
 The smoothing kernels are  "Gauss","Laplace", "Exponential" and "Bspline". The displacement at point \code{x} will be the weighted displacment vectors of the k-closest displacement vectors. Be \code{d} the distance to a neightbouring point, the weight will be calculated as:

Gaussian:  \eqn{w(d) = exp(\frac{-d^2}{2\sigma^2})}{w(d) = exp(-d^2/2*sigma^2)}

Laplacian: \eqn{w(d) = exp(\frac{-d}{\sigma})}{w(d) = exp(-d/sigma)}

Exponential: \eqn{w(d) = exp(\frac{-d}{2\sigma^2})}{w(d) = exp(-d/2*sigma^2)}
}
\examples{
require(Morpho)
data(nose)##load data
##warp a mesh onto another landmark configuration:
longnose.mesh <- tps3d(shortnose.mesh,shortnose.lm,longnose.lm)
### result won't be too good as the surfaces do stronly differ.
## we start with an affine transformation initiated by landmarks
affine <- list(iterations=20,subsample=100,rhotol=pi/2,uprange=0.9)
match <- gaussMatch(shortnose.mesh,longnose.mesh,lm1=shortnose.lm,
                   lm2=longnose.lm,gamma=2,iterations=10,smooth=1,smoothtype="h",
                   smoothit=10,nh=50,angtol=pi/2,affine=affine,sigma=20)

\dontrun{
## now a more cautiously approach using a larger neighbourhood
## (400 instead of 50) and no intermediary smoothing:
matchNoSmooth <- gaussMatch(shortnose.mesh,longnose.mesh,lm1=shortnose.lm,
                   lm2=longnose.lm,gamma=2,iterations=20,,nh=400,angtol=pi/2,
                   affine=affine,sigma=20)
}
}
\references{
Bryan, R., Mohan, P. S., Hopkins, A., Galloway, F., Taylor, M.,
and Nair, P. B. 2010. Statistical modelling of the whole human femur
incorporating geometric and material properties. Medical Engineering &amp;
Physics, 32(1):57-65.

Moshfeghi, M., Ranganath, S., and Nawyn, K. 1994. Three-dimensional elastic
matching of volumes. IEEE Transactions on Image Processing: A Publication of
the IEEE Signal Processing Society, 3(2):128-138.
}
\seealso{
\code{\link{meshres}}, \code{\link{vcgClost}},
\code{\link{vcgBorder}}, \code{\link{icp}}, \code{\link{vcgSmooth}}

\code{\link{outsideBBox},\link{getMeshBox} }
}
\author{
Stefan Schlager
}
