#include <cassert>
#include <cmath>
#include <vector>
#include "Point.hpp"
#include "Graph.hpp"
#include "TSPSolver.hpp"
#include "Tour.hpp"

int main() {
    // Four corners of a unit square; optimal TSP cycle length = 4.0
    std::vector<Point> pts = {
        Point(0, 0.0, 0.0),
        Point(1, 1.0, 0.0),
        Point(2, 1.0, 1.0),
        Point(3, 0.0, 1.0)
    };
    Graph g(pts);

    // 1) Nearest-Neighbor must produce something ≤ 1.5× optimal (i.e. ≤ 6.0 here).
    Tour nnTour = TSPSolver::runNearestNeighbor(g, 0);
    double nnLen = nnTour.length(g);
    assert(nnLen <= 4.0 * 1.5 && "NN should be ≤ 1.5× optimal (i.e. ≤ 6.0 for a square)");

    // 2) 2-Opt should find the optimal cycle of length exactly 4.0
    Tour optTour = TSPSolver::run2Opt(g, nnTour);
    double optLen = optTour.length(g);
    assert(std::fabs(optLen - 4.0) < 1e-6 && "2-Opt should find the optimal square tour (4.0)");

    return 0;
}
