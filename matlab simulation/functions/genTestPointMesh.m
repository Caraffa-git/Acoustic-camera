function test_points= genTestPointMesh(a, n_a, b, n_b, r)
    % Create the X and Z grids
    [X, Z] = meshgrid(linspace(-a/2, a/2, n_a), linspace(-b/2, b/2, n_b));
    
    % Adjust the Y coordinates to be at a distance r from the origin along the Y-axis
    Y = ones(size(X)) * r;
    
    % Combine the X, Y, and Z grids into a single 3D point cloud
    test_points = [X(:), Y(:), Z(:)];
    test_points = test_points';
end