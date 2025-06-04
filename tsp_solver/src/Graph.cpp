#include "Graph.hpp"

// Build a complete distance matrix based on Euclidean distances between Points.
Graph::Graph(const std::vector<Point> &points)
    : points_(points),
      adjMatrix_(points.size(), std::vector<double>(points.size(), 0.0))
{
    int n = size();
    for (int i = 0; i < n; ++i) {
        for (int j = i + 1; j < n; ++j) {
            double d = points_[i].distanceTo(points_[j]);
            adjMatrix_[i][j] = d;
            adjMatrix_[j][i] = d;
        }
    }
}
