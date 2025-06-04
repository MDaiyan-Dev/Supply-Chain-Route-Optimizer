#pragma once
#include <cmath>

// Represents a 2D point with an integer ID. Provides Euclidean distance.
struct Point {
    int id;
    double x, y;

    Point(int id_, double x_, double y_) : id(id_), x(x_), y(y_) {}

    double distanceTo(const Point &other) const {
        double dx = x - other.x;
        double dy = y - other.y;
        return std::hypot(dx, dy);
    }
};