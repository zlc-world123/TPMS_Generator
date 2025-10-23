function [vertices, faces] = generateShellModel(equation, gridSize,  unitXSize, unitYSize, unitZSize, periodsX, periodsY, periodsZ , isovalue)
    % 生成TPMS壳模型
    % 创建网格
    x = linspace(0, unitXSize*periodsX, gridSize*periodsX);
    y = linspace(0, unitYSize*periodsY, gridSize*periodsY);
    z = linspace(0, unitZSize*periodsZ, gridSize*periodsZ);
    [X, Y, Z] = meshgrid(x, y, z);
    
    % 计算TPMS场
    F = equation(X, Y, Z);
    
    % 提取等值面
    [faces, vertices] = isosurface(X, Y, Z, F, isovalue);
    
    % 确保顶点和面的格式正确
    if isempty(vertices) || isempty(faces)
        error('无法生成等值面，请调整等值面参数或网格尺寸');
    end
    
    fprintf('壳模型生成完成 - 顶点: %d, 面: %d\n', size(vertices, 1), size(faces, 1));
end