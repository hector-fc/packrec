module Visualization

using CairoMakie

"""
Plots the solution of the packing problem.

# Arguments
- `x`: Vector of x-coordinates for rectangle centers.
- `y`: Vector of y-coordinates for rectangle centers.
- `r`: Vector of rotation states (0 or 1) for each rectangle.
- `w`: Width of each rectangle.
- `h`: Height of each rectangle.
- `W`: Width of the container.
- `H`: Height of the container.
"""
function plot_solution(x::Vector{Float64}, y::Vector{Float64}, r::Vector{Int64}, w::Float64, h::Float64, W::Float64, H::Float64)
    # Create a new figure
    fig = Figure(size = (400, 400))
    ax = Axis(fig[1, 1], 
      title = "Packing Rectangles", 
      aspect = DataAspect())

    # Draw the container
    poly!(ax, [-W/2, W/2, W/2, -W/2], [-H/2, -H/2, H/2, H/2], color = :gray, transparency = 0.5, strokewidth = 2)

    # Draw rectangles
    for i in 1:length(x)
        # Determine rectangle dimensions based on rotation
        rw = r[i] == 0 ? w : h  # Width after rotation
        rh = r[i] == 0 ? h : w  # Height after rotation

        # Compute corners of the rectangle
        x_min = x[i] - rw / 2
        x_max = x[i] + rw / 2
        y_min = y[i] - rh / 2
        y_max = y[i] + rh / 2

        # Define rectangle as a polygon
        poly_x = [x_min, x_max, x_max, x_min]
        poly_y = [y_min, y_min, y_max, y_max]

        # Draw the rectangle
        poly!(ax, poly_x, poly_y, color = :green, transparency = 0.5, strokewidth = 1)
    end

    # Display the figure
    display(fig)
end

end
