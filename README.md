# 2024 CUMCM Problem A: Bench Dragon Motion Modeling

This repository contains our solution to Problem A of the 2024 China Undergraduate Mathematical Contest in Modeling (CUMCM), **“Bench Dragon”** (板凳龙).

The work models the complete inward-spiral, collision-limit, turning, and outward-spiral motion of a 223-bench dragon. It uses planar geometry and recursive kinematic relations to calculate handle positions and velocities, detect collisions, optimize the spiral pitch and turning path, and determine a safe maximum head speed.

## Highlights

- Models the bench-dragon path on an Archimedean spiral.
- Recursively computes the position and velocity of all 224 handles.
- Detects bench collisions and estimates the inward-spiral stopping time.
- Searches for the minimum feasible spiral pitch within a 9 m turning area.
- Models a two-arc S-shaped turning path and evaluates two effective radii.
- Estimates the maximum head speed subject to a 2 m/s handle-speed limit.

Selected numerical results reported in the paper:

| Item | Result |
| --- | --- |
| Collision-limit time | approximately 412.474054 s |
| Minimum feasible spiral pitch | approximately 0.450340 m |
| Minimum path length for effective radius 4.5 m | 13.714630 m |
| Minimum two-arc length before locking | 13.059333 m at effective radius 4.29 m |
| Maximum head speed, radius 4.5 m | 1.232 m/s |
| Maximum head speed, radius 4.29 m | 0.6313 m/s |

## Repository layout

```text
.
├── code/               MATLAB source code, grouped by problem
├── results/            Output spreadsheets required by the contest
├── paper/              Complete Chinese-language paper (PDF)
├── problem/            Original Problem A statement (PDF)
└── figures/            Selected figures and MATLAB figure files
```

## Requirements

- MATLAB with standard numerical and plotting functions
- Optimization Toolbox is recommended for functions such as `fzero`

The implementation was written for the contest workflow and consists of independent scripts for Problems 1–5. No external MATLAB packages are required.

## Running the code

Open MATLAB, change into the directory for the desired problem, and run its entry script:

```matlab
cd code/problem1
problem1
```

Replace `problem1` with `problem2`, `problem3`, `problem4`, or `problem5` as needed. Keep each entry script in its own directory so MATLAB resolves the matching helper functions.

Some scripts perform fine-grained numerical searches and may take a long time. Output workbooks generated during the original contest run are included in `results/` for reference.

## Paper

The complete paper is available at [`paper/paper.pdf`](paper/paper.pdf). It is written in Chinese and titled:

> 几何视域下板凳龙在盘龙全过程的姿态研究

English title: *A Geometric Study of Bench-Dragon Posture Throughout the Coiling Process*.

## Reproducibility notes

- Distances are expressed in metres in the MATLAB implementation unless a comment states otherwise.
- The dragon contains one head bench, 221 body benches, and one tail bench, represented by 224 handle points.
- The repository preserves the original contest code with only the surrounding project organization and documentation added.

## License and reuse

No open-source license has been granted. The paper, code, data, and figures remain under their respective authors' and source owners' copyrights. Please contact the authors before reuse beyond what applicable law permits.

## Acknowledgment

This project was prepared for the 2024 China Undergraduate Mathematical Contest in Modeling. The original Problem A statement is included for context and remains the property of its publisher.
