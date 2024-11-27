module Modeling

  using JuMP
  using GLPK

  export buildModel

  # Helper functions for rotated width and height
  function wf(r, w, h)
    return (1 - r) * w + r * h
  end

  function hf(r, w, h)
    return (1 - r) * h + r * w
  end

  """
  Builds the packing optimization model for `n` rectangles.

  # Arguments
  - `n`: Number of rectangles.
  - `w`: Width of each rectangle.
  - `h`: Height of each rectangle.
  - `bigM`: Large constant for constraints.
  - `W`: Width of the larger container.
  - `H`: Height of the larger container.

  # Returns
  A JuMP model for the packing problem.
  """
  function buildModel(n, w, h, bigM, W, H)
  # Initialize model
  model = Model(GLPK.Optimizer)
  set_attribute(model, "tm_lim", 1 * 60 * 1000)  # Time limit in milliseconds, 1 minute
  set_attribute(model, "msg_lev", GLPK.GLP_MSG_OFF)  # Suppress solver messages

  # Variables
  @variable(model, -W/2<=x[i=1:n] <= W/2)  # x-coordinates of centers
  @variable(model, -H/2<=y[i=1:n] <= H/2)  # y-coordinates of centers
  @variable(model, r[i = 1:n], Bin)          # Rotation variables
  @variable(model, q[i = 1:n, j = 1:n, k = 1:4], Bin)  # Non-overlap variables

  # Non-overlap constraints
  for i in 1:n
    for j in i+1:n
      @constraint(model, 0.5 * (wf(r[i], w, h) + wf(r[j], w, h)) - x[i] + x[j] <= bigM * q[i, j, 1])
      @constraint(model, 0.5 * (wf(r[i], w, h) + wf(r[j], w, h)) + x[i] - x[j] <= bigM * q[i, j, 2])
      @constraint(model, 0.5 * (hf(r[i], w, h) + hf(r[j], w, h)) - y[i] + y[j] <= bigM * q[i, j, 3])
      @constraint(model, 0.5 * (hf(r[i], w, h) + hf(r[j], w, h)) + y[i] - y[j] <= bigM * q[i, j, 4])
      @constraint(model, q[i, j, 1] + q[i, j, 2] + q[i, j, 3] + q[i, j, 4] == 3)
    end
  end
  # Boundary constraints
  @constraint(model, [i = 1:n], y[i] + 0.5 * hf(r[i], w, h) <= H / 2)
  @constraint(model, [i = 1:n], y[i] - 0.5 * hf(r[i], w, h) >= -H / 2)
  @constraint(model, [i = 1:n], x[i] + 0.5 * wf(r[i], w, h) <= W / 2)
  @constraint(model, [i = 1:n], x[i] - 0.5 * wf(r[i], w, h) >= -W / 2)
  return model
  end

end
