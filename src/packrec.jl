module packrec

  # Include submodules
  include("modeling.jl")
  include("visualization.jl")

  # Load dependencies
  using GLPK
  using JuMP  
  using CairoMakie
  using .Modeling
  using .Visualization

  # Exported functions
  export findMaxRec

  """
  Find the maximum number of rectangles `(w, h)` that can fit into a container `(W, H)`.

  # Arguments
  - `w`: Width of each rectangle.
  - `h`: Height of each rectangle.
  - `W`: Width of the container.
  - `H`: Height of the container.
  - `bigM`: Large constant for constraints.

  # Returns
  The maximum number of rectangles and a plot of the solution.
  """
  function findMaxRec(
    w::Float64, 
    h::Float64,
    W::Float64, 
    H::Float64, 
    bigM::Float64 = 100.0)

    niter = 2  # Start with one rectangle
    total_time = 0.0  # Track total solve time

    x = nothing  
    y = nothing  
    r = nothing  

    while true
      # Build and solve the model for `niter` rectangles
      model = Modeling.buildModel(niter, w, h, bigM, W, H)
      start_time = time()
      optimize!(model)
      solve_time = time() - start_time
      total_time += solve_time

      # Check if the solution is feasible
      if termination_status(model) == MOI.OPTIMAL
        # Try with one more rectangle
        niter += 1  
        # Extract variable values for visualization      
        x = value.(model[:x])
        y = value.(model[:y])
        r = value.(model[:r]) .|> round .|> Int  # Ensure binary values        
        # Visualize the solution
        
      else
        println("Maximum number of rectangles that can fit:", niter - 1)
        
        break
      end
    end
    Visualization.plot_solution(x, y, r, w, h, W, H)      
    println("Total solve time:", total_time, " seconds.")
    return niter - 1
  end
end


