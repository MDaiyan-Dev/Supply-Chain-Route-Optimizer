#pragma once
#include "Point.hpp"
#include <vector>

// A complete graph over a set of Points. Precomputes all pairwise Euclidean distances.
class Graph {
public:
    // Constructs a complete-graph distance matrix from the given points (size = n).
    Graph(const std::vector<Point> &points);

    // Returns distance between node id1 and id2 (0 <= id < n).
    double distance(int id1, int id2) const {
        return adjMatrix_[id1][id2];
    }

    // Number of nodes in the graph.
    int size() const { return static_cast<int>(points_.size()); }

    // Access to the stored Point by index (id).
    const Point& point(int id) const { return points_[id]; }

private:
    std::vector<Point> points_;
    std::vector<std::vector<double>> adjMatrix_;
};
