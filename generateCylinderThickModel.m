function [vertices, faces] = generateCylinderThickModel(equation, gridSize,  unitRSize, unitThetaSize, unitZrSize, periodsR , periodsZr , innerRadius , isovalue, thickness)
    % 生成有厚度的TPMS模型
    % 创建网格
    r = linspace(innerRadius, innerRadius + unitRSize * periodsR, gridSize*periodsR);
    theta = linspace(0, 2*pi, gridSize*unitThetaSize);
    z = linspace(0, unitZrSize*periodsZr, gridSize*periodsZr);
    [R, Theta, Z] = meshgrid(r, theta, z);
    X = R .* cos(Theta);
    Y = R .* sin(Theta);
    
    % 计算TPMS场
    F = abs(equation(R, Theta, Z))-thickness./2;
    
    % 生成两个等值面（内外表面）
    [faces1, vertices1] = isosurface(X, Y, Z, F, isovalue);
    %[faces2, vertices2] = isosurface(X, Y, Z, F, isovalue - thickness);
    
    if isempty(vertices1)
        error('无法生成等值面，请调整等值面参数或厚度参数');
    end
    
    % 生成端盖封闭表面
    [capFaces1, capVertices1] = isocaps(X, Y, Z, F, isovalue, 'enclose','below');
    %[capFaces2, capVertices2] = isocaps(X, Y, Z, F, isovalue - thickness, 'enclose','above');
    
    % 合并所有顶点和面
    vertices = [vertices1; capVertices1];
    
    % 调整面索引
    nv1 = size(vertices1, 1);
    %nv2 = size(vertices2, 1);
    %nv3 = size(capVertices1, 1);
    
    %faces2 = faces2 + nv1;
    capFaces1 = capFaces1 + nv1;
    %capFaces2 = capFaces2 + nv1 + nv2 + nv3;
    
    faces = [faces1;capFaces1;];
    
    fprintf('有厚度模型生成完成 - 顶点: %d, 面: %d\n', size(vertices, 1), size(faces, 1));
end