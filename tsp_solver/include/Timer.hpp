#pragma once
#include <chrono>
#include <string>
#include <iostream>

// Simple RAII timer: on destruction, prints "<label> took <ms> ms".
class Timer {
public:
    explicit Timer(const std::string &label)
        : label_(label), start_(Clock::now()) {}

    ~Timer() {
        auto end = Clock::now();
        double ms = std::chrono::duration<double, std::milli>(end - start_).count();
        std::cout << label_ << " took " << ms << " ms\n";
    }

private:
    using Clock = std::chrono::high_resolution_clock;
    std::string label_;
    Clock::time_point start_;
};
