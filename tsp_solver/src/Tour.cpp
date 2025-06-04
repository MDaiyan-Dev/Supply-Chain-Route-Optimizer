#include "Tour.hpp"
#include <algorithm>

// Initialize tour with [0, 1, 2, ..., n-1]
Tour::Tour(int n) : tour_(n) {
    for (int i = 0; i < n; ++i) {
        tour_[i] = i;
    }
}

// Sum up edges: (tour_[0]→tour_[1]) + (tour_[1]→tour_[2]) + ... + (tour_[n-2]→tour_[n-1]) + (tour_[n-1]→tour_[0])
double Tour::length(const Graph &g) const {
    double sum = 0.0;
    int n = size();
    if (n < 2) return 0.0;
    for (int i = 0; i < n - 1; ++i) {
        sum += g.distance(tour_[i], tour_[i + 1]);
    }
    sum += g.distance(tour_[n - 1], tour_[0]);
    return sum;
}

// Reverse the subsequence tour_[i..k] (inclusive).
void Tour::twoOptSwap(int i, int k) {
    std::reverse(tour_.begin() + i, tour_.begin() + k + 1);
}
