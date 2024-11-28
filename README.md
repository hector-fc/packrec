
# packrec


`packrec` is a Julia package designed to solve 2D packing retangles, where the goal is to maximize the number of rectangles that can be packed within a fixed container.

## Features

- Solves packing problems using optimization techniques with JuMP and GLPK.
- Includes visualization capabilities using CairoMakie.
- Flexible framework for defining and solving packing constraints.

## Installation

To install `packrec`, first clone this repository:

```bash
git clone https://github.com/hector-fc/packrec.git
cd packrec
 ```

## Usage 

Here's an example of how to use `packrec`:

```julia 
julia> using  packrec
# Set the parameters for cutting an A4 sheet into rectangles
julia> w = 12.0
julia> h = 6.0  # Rectangle width and height
julia> W = 21.0 
julia> H = 29.7  # Container width and height

# Solve for the maximum number of rectangles
julia> packrec.findMaxRec(w, h, W, H)
Maximum number of rectangles that can fit:6
Total solve time:61.684911251068115 seconds.
```

<img src="packrec.png" alt="packrec logo" width="100">

## Contributing   

Contributions are very welcome. 

## Authors

  * Hector F Callisaya  
  * Geisiane de Moura Vettorazzi
  





