#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <sstream>
#include "Point.hpp"
#include "Graph.hpp"
#include "TSPSolver.hpp"
#include "Tour.hpp"
#include "Timer.hpp"

// Trim whitespace from both ends of a string
static std::string trim(const std::string &s) {
    size_t first = s.find_first_not_of(" \t\r\n");
    if (first == std::string::npos) return "";
    size_t last = s.find_last_not_of(" \t\r\n");
    return s.substr(first, (last - first + 1));
}

/**
 * Attempts to read a file whose format is:
 *
 *    n
 *    id0 lon0 lat0
 *    id1 lon1 lat1
 *    ...
 *    id_{n-1} lon_{n-1} lat_{n-1}
 *
 * where n is the number of points. The function will store each line
 * into `points` as a Point(id, lon, lat).  If the first nonblank line
 * is not a single integer 'n', but instead already "id lon lat", it will
 * interpret that as the first data row and continue reading all lines
 * as data (no count-check).
 */
bool loadIDLonLatFile(const std::string &filename, std::vector<Point> &points) {
    std::ifstream in(filename);
    if (!in) {
        std::cerr << "Error: cannot open " << filename << "\n";
        return false;
    }

    std::vector<std::tuple<int, double, double>> raw;
    raw.reserve(128);

    std::string line;

    // 1) Read the first nonempty line
    while (std::getline(in, line)) {
        line = trim(line);
        if (!line.empty()) break;
    }
    if (in.fail() || line.empty()) {
        std::cerr << "Error: file is empty or unreadable: " << filename << "\n";
        return false;
    }

    {
        std::istringstream iss(line);
        int a; double b, c;
        // Try parsing "id lon lat"
        if ((iss >> a >> b >> c) && iss.eof()) {
            // It is "id lon lat" format: treat that line as data
            raw.emplace_back(a, b, c);
        } else {
            // Maybe it's a single integer n
            std::istringstream iss2(line);
            int maybeN;
            if ((iss2 >> maybeN) && iss2.eof()) {
                // First line was count; now read exactly maybeN data lines
                int count = maybeN;
                for (int i = 0; i < count; ++i) {
                    if (!std::getline(in, line)) {
                        std::cerr << "Error: expected " << count
                                  << " data lines but file ended early.\n";
                        return false;
                    }
                    line = trim(line);
                    if (line.empty()) {
                        --i;  // skip blank line and try again
                        continue;
                    }
                    std::istringstream iss3(line);
                    int id; double lon, lat;
                    if (!(iss3 >> id >> lon >> lat)) {
                        std::cerr << "Warning: skipping malformed line: " << line << "\n";
                        --i; // don't count this as one of the data lines
                        continue;
                    }
                    raw.emplace_back(id, lon, lat);
                }
            } else {
                std::cerr << "Error: first nonempty line is neither 'n' nor 'id lon lat'.\n";
                return false;
            }
        }
    }

    // 2) Convert raw tuples into Points
    for (auto &t : raw) {
        int id;
        double lon, lat;
        std::tie(id, lon, lat) = t;
        points.emplace_back(id, lon, lat);
    }

    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <coords_file.txt>\n"
                  << "  File must have format:\n"
                  << "    n\n"
                  << "    id0 lon0 lat0\n"
                  << "    id1 lon1 lat1\n"
                  << "    ...\n";
        return 1;
    }

    std::string filename = argv[1];
    std::vector<Point> points;
    bool ok = loadIDLonLatFile(filename, points);
    if (!ok) {
        std::cerr << "Failed to parse whitespace-format input file '" << filename << "'.\n";
        return 1;
    }

    int n = static_cast<int>(points.size());
    if (n == 0) {
        std::cerr << "Error: no points loaded from file.\n";
        return 1;
    }

    // The Graph/Tour code expects node‐indices 0..n-1. If your IDs are
    // not already exactly 0..(n-1), we must re-index them.
    bool idsAreSequential = true;
    for (int i = 0; i < n; ++i) {
        if (points[i].id != i) {
            idsAreSequential = false;
            break;
        }
    }

    std::vector<Point> orderedPoints;
    orderedPoints.reserve(n);

    if (!idsAreSequential) {
        // Build a temporary array: temp[id] = that Point
        std::vector<Point> temp(n, Point(0, 0.0, 0.0));
        for (auto &pt : points) {
            if (pt.id < 0 || pt.id >= n) {
                std::cerr << "Error: ID out of range [0.." << (n-1) << "]: " << pt.id << "\n";
                return 1;
            }
            temp[pt.id] = pt;
        }
        for (int i = 0; i < n; ++i) {
            // Now reassign ID = i, (lon, lat) unchanged
            orderedPoints.emplace_back(i, temp[i].x, temp[i].y);
        }
    } else {
        orderedPoints = points;
    }

    // Build the Graph from orderedPoints
    Graph graph(orderedPoints);

    // 1) Run Nearest-Neighbor
    Tour nnTour(0);
    {
        Timer t("Nearest-Neighbor");
        nnTour = TSPSolver::runNearestNeighbor(graph, 0);
    }
    double nnLen = nnTour.length(graph);
    std::cout << "NN tour length: " << nnLen << "\n";

    // 2) Run 2-Opt to improve
    Tour optTour(0);
    {
        Timer t("2-Opt Improvement");
        optTour = TSPSolver::run2Opt(graph, nnTour);
    }
    double optLen = optTour.length(graph);
    std::cout << "2-Opt tour length: " << optLen << "\n";

    // 3) Print a map-friendly CSV: order,id,lon,lat
    std::cout << "order,id,lon,lat\n";
    const auto &route = optTour.route();
    for (int i = 0; i < (int)route.size(); ++i) {
        int idx = route[i];                  // internal index 0..n-1
        int originalID = orderedPoints[idx].id; 
        double lon = orderedPoints[idx].x;
        double lat = orderedPoints[idx].y;
        std::cout << i << "," << originalID << "," << lon << "," << lat << "\n";
    }

    return 0;
}
// End of src/main.cpp