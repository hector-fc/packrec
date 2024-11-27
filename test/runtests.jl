using Test
using packrec

@testset "Packing Problem Tests" begin
  # Test model creation
  w, h = 12.0, 6.0
  W, H = 21.0, 29.7
  bigM = 100.0
  n = 3

  model = Modeling.buildModel(n, w, h, bigM, W, H)
  @test typeof(model) == JuMP.Model

  # Test visualization (ensure no errors are raised)
  x = [-10.0, 0.0, 10.0]
  y = [0.0, 15.0, -15.0]
  r = [0, 1, 0]
  Visualization.plot_solution(x, y, r, w, h, W, H)
end

