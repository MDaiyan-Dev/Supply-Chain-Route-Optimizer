#include "TSPSolver.hpp"
#include <limits>
#include <vector>

// Nearest-Neighbor: Start at startId, repeatedly pick the closest unvisited node.
Tour TSPSolver::runNearestNeighbor(const Graph &g, int startId) {
    int n = g.size();
    std::vector<bool> visited(n, false);
    Tour tour(n);
    std::vector<int> &route = tour.route();

    int current = startId;
    route[0] = current;
    visited[current] = true;

    for (int i = 1; i < n; ++i) {
        double bestDist = std::numeric_limits<double>::infinity();
        int nextNode = -1;
        for (int j = 0; j < n; ++j) {
            if (!visited[j]) {
                double d = g.distance(current, j);
                if (d < bestDist) {
                    bestDist = d;
                    nextNode = j;
                }
            }
        }
        route[i] = nextNode;
        visited[nextNode] = true;
        current = nextNode;
    }
    return tour;
}

// 2-Opt first-improvement: scan all (i,k) pairs; if reversing [i..k] reduces length, perform it and restart.
Tour TSPSolver::run2Opt(const Graph &g, const Tour &initial) {
    Tour tour = initial;  // copy
    int n = tour.size();
    bool improvement = true;

    while (improvement) {
        improvement = false;
        double bestDelta = 0.0;
        int bestI = -1, bestK = -1;

        // Examine every possible pair (i, k) with 1 ≤ i < k < n
        for (int i = 1; i < n - 1; ++i) {
            for (int k = i + 1; k < n; ++k) {
                int a = tour.route()[i - 1];
                int b = tour.route()[i];
                int c = tour.route()[k];
                int d = tour.route()[(k + 1) % n];

                // Current edges: (a—b) + (c—d)
                // New edges after swap: (a—c) + (b—d)
                double delta = (g.distance(a, c) + g.distance(b, d))
                             - (g.distance(a, b) + g.distance(c, d));

                if (delta < bestDelta) {
                    bestDelta = delta;
                    bestI = i;
                    bestK = k;
                }
            }
        }

        if (bestDelta < -1e-9) {
            tour.twoOptSwap(bestI, bestK);
            improvement = true;
        }
    }

    return tour;
}
