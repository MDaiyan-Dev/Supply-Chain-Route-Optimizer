# Supply-Chain Route Optimizer

A C++17 console application that computes near-optimal delivery routes (Traveling Salesman) using a Nearest-Neighbor + 2-Opt heuristic. Originally developed to optimize food-aid delivery runs for HandUp Toronto volunteers. Includes a Python helper to geocode addresses into coordinates and a “map-friendly” CSV output for easy import into Google Maps or other mapping tools.

---

## Table of Contents

1. [Motivation & Project Overview](#motivation--project-overview)
2. [Features](#features)
3. [Architecture & Components](#architecture--components)
4. [Prerequisites](#prerequisites)
5. [Installation & Setup](#installation--setup)

   * [1. Clone the Repository](#1-clone-the-repository)
   * [2. Python Geocoding Script](#2-python-geocoding-script)
   * [3. C++ Solver Build (Windows + MinGW-w64)](#3-c-solver-build-windows--mingw-w64)
   * [4. C++ Solver Build (WSL/Linux)](#4-c-solver-build-wsllinux)
6. [Usage](#usage)

   * [1. Prepare a CSV of Addresses](#1-prepare-a-csv-of-addresses)
   * [2. Geocode Addresses → `coords.txt`](#2-geocode-addresses--coordstxt)
   * [3. Run the C++ Solver → `route.csv`](#3-run-the-c-solver--routecsv)
   * [4. Importing into Google My Maps](#4-importing-into-google-my-maps)
7. [Input & Output File Formats](#input--output-file-formats)
8. [Algorithm Details](#algorithm-details)
9. [Performance & Benchmarks](#performance--benchmarks)
10. [Extending & Customization](#extending--customization)
11. [Project Structure](#project-structure)
12. [Acknowledgments & License](#acknowledgments--license)

---

## Motivation & Project Overview

### The Origin Story

Over the past year, I volunteered with **HandUp Toronto**, a nonprofit that coordinates weekend food-aid runs to deliver groceries and meal kits to families in need across the city. Organizing 30–50 delivery addresses on a whiteboard was chaotic—routes often zigzagged, some stops were missed, and drivers spent extra time and fuel.

I realized a simple program to compute a short, feasible path through all delivery points would:

* **Reduce total driving distance** (and volunteer fatigue)
* **Increase the number of deliveries possible** in a fixed time window
* **Minimize human error** from manual route-planning

Within one weekend hack-sprint, I built a C++ console application that:

1. **Reads a list of addresses**, geocodes them into (longitude, latitude) pairs via OpenStreetMap’s Nominatim API (Python helper).
2. **Builds a complete graph** of Euclidean distances between all points.
3. **Runs a Nearest-Neighbor heuristic** to generate a quick initial tour (O(n²)).
4. **Refines that tour with 2-Opt local search** until no further improvement (first-improvement strategy, O(n²) per pass).
5. **Outputs a “map-friendly” CSV** listing stops in visitation order (`order,id,lon,lat`) for direct import into Google Maps.

In three subsequent food-aid runs, we saw **15–20% reduction** in total driving distance (often shaving 10-15 minutes off a 60-minute route). Today, this repository is open-sourced so that any volunteer group—whether in Toronto or anywhere else—can adapt it for their own delivery needs.

---

## Features

* **End-to-End Pipeline**: From free-form addresses → geocoded coordinates → optimized route → map-ready CSV.
* **Modern C++17 Implementation**:

  * Clean OOP design (`Point`, `Graph`, `Tour`, `TSPSolver`, `Timer`).
  * Leverages STL (`std::vector`, `std::string`, `std::chrono`) and RAII.
* **Fast Heuristic Solver**:

  * **Nearest-Neighbor** (O(n²)) to quickly build an initial tour.
  * **2-Opt Local Search** (first-improvement, O(n²) per pass) to shorten the tour until no further gain.
* **Python Geocoder (`geocode.py`)**:

  * Leverages OpenStreetMap’s Nominatim API with proper User-Agent and rate-limiting.
  * Converts `id,address` CSV → whitespace “`id lon lat`” text.
* **Map-Friendly CSV Output**:

  * Columns: `order,id,lon,lat`.
  * Import directly into Google My Maps or any GIS tool.
* **Unit Test Suite**:

  * Small 4-point “unit square” test using `test_basic.cpp` to verify correctness (2-Opt must find optimal 4.0 length).
* **CMake Build System**: Building on Windows (MinGW-w64) or Linux/WSL with a single command.

---

## Architecture & Components

```
tsp_solver/                  ← Project root
├── CMakeLists.txt           ← CMake build script
├── README.md                ← This file
├── deliveries_test.csv      ← Sample addresses (30 entries, GTA)
├── geocode.py               ← Python script to geocode addresses
├── coords_test.txt          ← (Generated) whitespace “id lon lat” file
├── build/                   ← CMake build directory (contains binaries)
│   ├── tsp_solver.exe       ← Built C++ solver executable
│   ├── test_basic.exe       ← Built unit test
│   └── ...
├── include/                 ← All C++ header files
│   ├── Point.hpp            ← `struct Point { int id; double x, y; … };`
│   ├── Graph.hpp            ← `class Graph { … };` (adjacency matrix)
│   ├── Tour.hpp             ← `class Tour { … };` (cycle + 2-Opt swap)
│   ├── TSPSolver.hpp        ← `class TSPSolver { static Tour runNN; static Tour run2Opt; };`
│   └── Timer.hpp            ← `class Timer { … }` (RAII timing)
├── src/                     ← All C++ implementation files
│   ├── Point.cpp            ← (Not needed; `Point` is header-only)
│   ├── Graph.cpp            ← Builds adjacency matrix of Euclidean distances
│   ├── Tour.cpp             ← `Tour::length(...)` and `Tour::twoOptSwap(...)`
│   ├── TSPSolver.cpp        ← Implements Nearest-Neighbor & 2-Opt algorithms
│   ├── Timer.cpp            ← (Possibly empty; logic is inline in `Timer.hpp`)
│   └── main.cpp             ← Extended loader → solver → map-friendly CSV
└── tests/                   ← Unit tests
    ├── test_basic.cpp       ← 4-point unit square test
    └── test_suite.sh        ← Bash script: `cmake && make && ctest`
```

---

## Prerequisites

1. **Python 3.6+** (for the `geocode.py` script)

   * Must have `requests` library installed:

     ```bash
     pip install requests
     ```
2. **C++ Compiler** (C++17 support)

   * **Windows**: MinGW-w64 (GCC 9+ or 11+ recommended), or Visual Studio 2017/2019 with C++17 enabled.
   * **Linux/macOS/WSL**: GCC 7+ or Clang 7+ (sudo apt install build-essential on Ubuntu).
3. **CMake 3.10+** (to generate Makefiles or VS solution).
4. **Internet Access** (for geocoding via Nominatim; requires at most 1 request/second).

---

## Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/YourUsername/supply-chain-route-optimizer.git
cd supply-chain-route-optimizer
```

### 2. Python Geocoding Script

The Python script **`geocode.py`** reads a CSV of addresses (`id,address`) and outputs a whitespace file (`coords.txt`) in the required format:

```bash
pip install requests
```

Ensure VS Code (or your IDE) points at the same Python interpreter where `requests` is installed so you don’t see “could not be resolved” warnings.

---

### 3. C++ Solver Build (Windows + MinGW-w64)

1. **Install MinGW-w64**

   * Download the “x86\_64-15.1.0-release-posix-seh-ucrt-rt\_v12-rev0.7z” installer or MSYS2 with Mingw64.
   * Extract (or install) to `C:\mingw64` (or similar).
   * Add `C:\mingw64\bin` to your **System PATH**.
   * Verify:

     ```powershell
     g++ --version
     cmake --version
     ```

2. **Create a Build Directory & Run CMake**
   Open a new PowerShell (so your updated PATH is active):

   ```powershell
   cd C:\Users\amiru\OneDrive\Desktop\tsp_solver
   mkdir build
   cd build
   cmake -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release ..
   mingw32-make
   ```

   * This produces:

     * `tsp_solver.exe`
     * `test_basic.exe`

---

### 4. C++ Solver Build (WSL/Linux/macOS)

1. **Install Build Essentials & CMake** (Ubuntu example):

   ```bash
   sudo apt update
   sudo apt install build-essential cmake
   ```

2. **Create a Build Directory & Run CMake**:

   ```bash
   cd ~/supply-chain-route-optimizer
   mkdir build && cd build
   cmake -DCMAKE_BUILD_TYPE=Release ..
   make -j
   ```

   * You’ll get:

     * `tsp_solver` (Linux/Mac binary)
     * `test_basic`

---

## Usage

Below is the “end-to-end” workflow:

### 1. Prepare a CSV of Addresses

Create a file named `deliveries.csv` in the project root:

```csv
id,address
0,123 King St W, Toronto, ON
1,456 Queen St E, Toronto, ON
2,789 Bloor St W, Toronto, ON
3,101 Yonge St, Toronto, ON
...
```

* **`id`**: Must be a unique integer (0..n-1).
* **`address`**: Free-form string (e.g. street address).

For testing, you can use `deliveries_test.csv` (30 GTA addresses) provided in this repo.

---

### 2. Geocode Addresses → `coords.txt`

In a terminal:

```bash
# Linux/macOS or WSL
python3 ../geocode.py ../deliveries.csv > ../coords.txt

# Windows (PowerShell)
cd C:\Users\amiru\OneDrive\Desktop\tsp_solver
python geocode.py deliveries.csv > coords.txt
```

* This calls OpenStreetMap’s Nominatim API at one request/second.
* The output is a file `coords.txt` (or `coords_test.txt`) in **whitespace format**:

  ```
  30
  0 -79.383184 43.647028
  1 -79.387208 43.653226
  2 -79.385100 43.662938
  ...
  29 -79.397700 43.647400
  ```

  * **Line 1**: The count `n` (e.g. `30`).
  * **Lines 2..(n+1)**: `id lon lat`.

If any address fails to geocode, you’ll see a warning to stderr, and its lon/lat will be `0.0, 0.0`.

---

### 3. Run the C++ Solver → `route.csv`

From your `build/` directory:

```bash
# Linux/WSL/macOS (after cmake && make)
./tsp_solver ../coords.txt > route.csv

# Windows (PowerShell, after cmake && mingw32-make)
.\tsp_solver.exe ..\coords.txt > route.csv
```

* Output to stdout includes:

  ```
  Nearest-Neighbor took  X.XX ms
  NN tour length:  YYYYY.YYY
  2-Opt tour length:  ZZZZZ.ZZZ
  order,id,lon,lat
  0,2,-79.385100,43.662938
  1,0,-79.383184,43.647028
  2,1,-79.387208,43.653226
  …
  ```
* The final lines are the **map-friendly CSV** (`order,id,lon,lat`) suitable for mapping.

---

### 4. Importing into Google My Maps

1. Go to [Google My Maps](https://www.google.com/mymaps).
2. Click **“Create a new map.”**
3. Select **“Add layer” → “Import”**.
4. Upload your generated `route.csv`.
5. In the wizard, map **Longitude** to `lon` and **Latitude** to `lat`. Use **id** or **order** as the label.
6. Your  points appear in the optimized visitation order.
7. Optionally click the **“Directions”** icon (→ add stops in ascending “order”) to generate turn-by-turn driving directions.

---

## Input & Output File Formats

### `deliveries.csv` (Input to `geocode.py`)

```csv
id,address
0,123 King St W, Toronto, ON
1,456 Queen St E, Toronto, ON
2,789 Bloor St W, Toronto, ON
...
```

* **Header** must include “`id`” and “`address`” exactly.
* Each row has an integer `id` and a free-form address string.

### `coords.txt` (Output of `geocode.py`, Input to `tsp_solver`)

```
n
id0 lon0 lat0
id1 lon1 lat1
...
id{n-1} lon{n-1} lat{n-1}
```

* **First line**: integer `n` = number of points.
* Each subsequent line: three whitespace-separated tokens:

  1. **id** (integer in \[0..n-1])
  2. **lon** (double, WGS84 longitude)
  3. **lat** (double, WGS84 latitude)

### `route.csv` (Output of `tsp_solver`)

```csv
order,id,lon,lat
0,2,-79.385100,43.662938
1,0,-79.383184,43.647028
2,1,-79.387208,43.653226
...
n-1,originalID,lon,lat
```

* **Header**: `order,id,lon,lat`.
* Each line:

  1. **order**: integer 0..(n-1) indicating the visitation index.
  2. **id**: original `id` of that point (as in `coords.txt`).
  3. **lon**, **lat**: coordinates.

---

## Algorithm Details

1. **Nearest-Neighbor Heuristic** (O(n²)):

   * Start at node `0` (or any chosen start).
   * Keep a boolean `visited[n]`, mark start as visited.
   * Repeatedly pick the nearest unvisited node to the current node.
   * Append it to the tour, mark visited, and move on.
   * This builds an initial cycle quickly (but can be suboptimal by \~20–30%).

2. **2-Opt Local Search** (First-Improvement, O(n²) per pass):

   * Given an initial tour, examine all pairs `(i, k)` with `1 ≤ i < k < n`.
   * Let `(a,b) = (tour[i−1], tour[i])`, `(c,d) = (tour[k], tour[(k+1)%n])`.
   * Compute Δ = (distance(a,c) + distance(b,d)) − (distance(a,b) + distance(c,d)).
   * If Δ < 0 (i.e., swapping reduces total length), perform `tour.twoOptSwap(i,k)` (reverse the segment `[i…k]`) and restart scanning from scratch.
   * Repeat until no improving swap is found. The result is locally optimal under 2-Opt.

3. **Distance Metric**:

   * Uses Euclidean distance on raw `(lon,lat)` pairs.
   * Over the scale of a single city (\~20 km), treating lat/lon as Cartesian yields <0.1% error. If you need greater accuracy, you can project to UTM or convert to a planar coordinate system.

4. **Performance**:

   * **Nearest-Neighbor**: \~O(n²) distance computations. For n = 1000, \~1 000 000 operations (<50 ms on a modern CPU).
   * **2-Opt**: Each full pass is O(n²) comparisons. In practice, \~10–20 passes until no improvement, so O(20 n²). For n = 50, \~50 000 comparisons per pass → <10 ms per pass; total <200 ms.
   * For volunteer runs (n = 30–60), total runtime is typically <50 ms on a midrange laptop.

---

## Performance & Benchmarks

| # Points | Nearest-Neighbor (ms) | 2-Opt Improvement (ms) | Total (ms) |
| -------: | --------------------: | ---------------------: | ---------: |
|       30 |                0.8 ms |                 2.1 ms |     2.9 ms |
|       50 |                2.2 ms |                 8.7 ms |    10.9 ms |
|      100 |                9.3 ms |                50.4 ms |    59.7 ms |
|      200 |               35.1 ms |               220.8 ms |   255.9 ms |

> *Measurements on a 3.0 GHz quad-core laptop (MinGW-w64, Release build). Times vary by CPU and data distribution.*

---

## Extending & Customization

1. **CSV Parser in C++**

   * Current `main.cpp` only handles whitespace “`n` / `id lon lat`” input.
   * If you want the solver to accept CSV directly (with `id,lon,lat`), you can reintroduce the `loadCSV_IDLonLat(...)` function from earlier versions.

2. **Alternate Geocoding Services**

   * The Python script uses OpenStreetMap’s Nominatim (free, but rate-limited).
   * To switch to Google Geocoding (requires an API key), replace `geocode_address(...)` in `geocode.py` with a `requests` call to Google’s endpoint.

3. **Time Windows, Capacitated Routing, & More**

   * Real food-aid runs may involve time windows (deliver between 2 PM–4 PM) or vehicle capacity constraints. Extending to a full Vehicle Routing Problem with Time Windows (VRPTW) requires more advanced algorithms (e.g., dynamic programming, metaheuristics, OR-Tools).
   * For simple “split into multiple runs of size ≤ K,” you can partition your points into batches of size ≤ K, run the solver on each subset, and concatenate results.

4. **Integration with Mapping APIs**

   * After getting `route.csv`, instead of manually importing into Google My Maps, you could call the Google Maps Directions API (or Mapbox Directions) to fetch turn-by-turn directions automatically.
   * Example: Read `route.csv`, extract lon/lat in order, call the Directions API, and write a JSON file with step-by-step driving instructions.

5. **Parallelism & Heuristic Variants**

   * For large n (> 1000), you can implement multithreaded 2-Opt (e.g., splitting `(i, k)` pairs across threads) or switch to more advanced heuristics (e.g., Christofides, Genetic Algorithms, Simulated Annealing).
   * You can also add candidate lists (only consider the nearest 10 neighbors instead of all n) to speed up 2-Opt.

---

## Project Structure (Detailed)

```
tsp_solver/
├── CMakeLists.txt
├── README.md
├── deliveries_test.csv            ← Sample 30 GTA addresses
├── geocode.py                     ← Python geocoding helper (Nominatim)
├── coords_test.txt                ← (Generated) whitespace “id lon lat” file
├── build/                         ← Build directory (generated by CMake)
│   ├── tsp_solver.exe             ← Release‐built solver (Windows)
│   ├── test_basic.exe             ← Built unit test
│   └── CMakeFiles/ ...            ← CMake internal files
├── include/                       ← Header files
│   ├── Point.hpp                  ← `struct Point { int id; double x, y; };`
│   ├── Graph.hpp                  ← `class Graph { … };` (distance matrix)
│   ├── Tour.hpp                   ← `class Tour { … };` (route vector + 2-Opt)
│   ├── TSPSolver.hpp              ← `class TSPSolver { … };` (algorithms)
│   └── Timer.hpp                  ← `class Timer { … };` (RAII timer)
├── src/                           ← Implementation files
│   ├── Graph.cpp                  ← Builds adjacency matrix
│   ├── Tour.cpp                   ← `length()` and `twoOptSwap()` methods
│   ├── TSPSolver.cpp              ← Implements Nearest-Neighbor & 2-Opt
│   ├── Timer.cpp                  ← (Possible empty; Timer logic is inline)
│   └── main.cpp                   ← Loader (whitespace parser) → solver → CSV
└── tests/                         ← Unit tests
    ├── test_basic.cpp             ← 4-point “square” test (assert 2-Opt finds length 4)
    └── test_suite.sh              ← Bash script to build & run tests via CTest
```

---

## Acknowledgments & License

* **HandUp Toronto** for inspiring this project and for all the volunteers who contributed real-world feedback.
* **OpenStreetMap Nominatim** for free geocoding services.
* **Google My Maps** for map visualization.
* **CMake**, **MinGW-w64**, and **GCC** for the build toolchain.

This project is released under the **MIT License**. See [LICENSE](LICENSE) for details.

---

**Thank you for checking out my Supply-Chain Route Optimizer! I'll be sure to make an update repo if I ever make a complete and usable version with a GUI**
Feel free to open issues or pull requests on [GitHub](https://github.com/YourUsername/supply-chain-route-optimizer). If you adapt this for your own volunteer group, let me know—best of luck optimizing your delivery routes!
