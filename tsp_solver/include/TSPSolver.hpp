#pragma once
#include "Graph.hpp"
#include "Tour.hpp"

// Provides two heuristics for the symmetric TSP over a complete graph:
// 1) Nearest-Neighbor to build an initial tour (O(n²))
// 2) First-improvement 2-Opt local search (O(n²) per pass)
class TSPSolver {
public:
    // Runs Nearest-Neighbor starting from node `startId`. Returns a Tour of size n.
    static Tour runNearestNeighbor(const Graph &g, int startId = 0);

    // Runs 2-Opt on a provided initial tour. Returns the locally improved Tour.
    static Tour run2Opt(const Graph &g, const Tour &initial);
};
