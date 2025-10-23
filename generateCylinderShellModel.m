function [vertices, faces] = generateCylinderShellModel(equation, gridSize,  unitRSize, unitThetaSize, unitZrSize, periodsR, periodsZr , innerRadius , isovalue)
    % 生成TPMS壳模型
    % 创建网格
    r = linspace(innerRadius, innerRadius + unitRSize * periodsR, gridSize*periodsR);
    theta = linspace(0, 2*pi, gridSize*unitThetaSize);
    z = linspace(0, unitZrSize*periodsZr, gridSize*periodsZr);
    [R, Theta, Z] = meshgrid(r, theta, z);
    X = R .* cos(Theta);
    Y = R .* sin(Theta);
    % 计算TPMS场
    F = equation(R, Theta, Z);
    
    % 提取等值面
    [faces, vertices] = isosurface(X, Y, Z, F, isovalue);
    
    % 确保顶点和面的格式正确
    if isempty(vertices) || isempty(faces)
        error('无法生成等值面，请调整等值面参数或网格尺寸');
    end
    
    fprintf('壳模型生成完成 - 顶点: %d, 面: %d\n', size(vertices, 1), size(faces, 1));
end