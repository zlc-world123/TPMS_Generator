function exportSTLFile(vertices, faces, filename)
    % 导出STL文件
    
    % 确保文件扩展名为.stl
    [filepath, name, ext] = fileparts(filename);
    if ~strcmpi(ext, '.stl')
        filename = fullfile(filepath, [name '.stl']);
    end
    
    % 打开文件
    fid = fopen(filename, 'w');
    if fid == -1
        error('无法创建文件: %s', filename);
    end
    
    try
        % 写入STL头文件
        fprintf(fid, 'solid TPMS_Structure\n');
        
        % 写入每个三角形面
        for i = 1:size(faces, 1)
            % 获取当前面的三个顶点
            v1 = vertices(faces(i, 1), :);
            v2 = vertices(faces(i, 2), :);
            v3 = vertices(faces(i, 3), :);
            
            % 计算法向量
            normal = cross(v2 - v1, v3 - v1);
            normal = normal / norm(normal);
            
            % 写入法向量
            fprintf(fid, '  facet normal %e %e %e\n', normal);
            fprintf(fid, '    outer loop\n');
            
            % 写入三个顶点
            fprintf(fid, '      vertex %e %e %e\n', v1);
            fprintf(fid, '      vertex %e %e %e\n', v2);
            fprintf(fid, '      vertex %e %e %e\n', v3);
            
            fprintf(fid, '    endloop\n');
            fprintf(fid, '  endfacet\n');
        end
        
        % 写入文件结束
        fprintf(fid, 'endsolid TPMS_Structure\n');
        
        fclose(fid);
        
        fprintf('STL文件已成功导出: %s\n', filename);
        
    catch ME
        fclose(fid);
        rethrow(ME);
    end
end