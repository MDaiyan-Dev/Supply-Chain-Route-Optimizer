#pragma once
#include <vector>
#include "Graph.hpp"

// Encapsulates a candidate TSP tour (cycle) over node IDs [0..n-1].
// Internally stores a sequence `tour_[0..n-1]`. Tour length = sum of edges + closing edge.
class Tour {
public:
    // Initialize with n nodes in the trivial tour [0,1,2,...,n-1].
    explicit Tour(int n);

    // Compute total cycle length using the provided Graph distances.
    double length(const Graph &g) const;

    // Perform a 2-Opt swap: reverse the segment [i..k] (inclusive).
    void twoOptSwap(int i, int k);

    // Access or modify the underlying route vector.
    const std::vector<int>& route() const { return tour_; }
    std::vector<int>& route() { return tour_; }

    int size() const { return static_cast<int>(tour_.size()); }

private:
    std::vector<int> tour_;
};
