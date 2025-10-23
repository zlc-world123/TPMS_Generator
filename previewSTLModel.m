function previewSTLModel(vertices, faces)
    % 预览STL模型的独立窗口
    
    % 创建预览窗口
    previewFig = figure('Name', 'STL预览', ...
                       'Position', [200 200 800 600], ...
                       'NumberTitle', 'off');
    
    % 创建子图布局
    ax = subplot(1, 1, 1);
    
    % 绘制模型
    patch(ax, 'Faces', faces, 'Vertices', vertices, ...
          'FaceColor', [0.8 0.8 1.0], ...
          'EdgeColor', 'none', ...
          'FaceAlpha', 0.9);
    
    % 设置坐标区属性
    axis(ax, 'equal');
    grid(ax, 'on');
    xlabel(ax, 'X');
    ylabel(ax, 'Y');
    zlabel(ax, 'Z');
    title(ax, 'TPMS结构预览');
    
    % 添加光照
    light(ax, 'Position', [1 1 1]);
    lighting(ax, 'gouraud');
    material(ax, 'dull');
    
    % 添加工具栏
    toolbar = uitoolbar(previewFig);
    
    % 添加视图按钮
    uitoggletool(toolbar, 'TooltipString', '正视图', ...
        'ClickedCallback', @(src,event) view(ax, 2));
    uitoggletool(toolbar, 'TooltipString', '侧视图', ...
        'ClickedCallback', @(src,event) view(ax, [1 0 0]));
    uitoggletool(toolbar, 'TooltipString', '顶视图', ...
        'ClickedCallback', @(src,event) view(ax, [0 0 1]));
    uitoggletool(toolbar, 'TooltipString', '等轴视图', ...
        'ClickedCallback', @(src,event) view(ax, 3));
    
    % 添加旋转按钮
    uipushtool(toolbar, 'TooltipString', '开始旋转', ...
        'ClickedCallback', @(src,event) startRotation());
    uipushtool(toolbar, 'TooltipString', '停止旋转', ...
        'ClickedCallback', @(src,event) stopRotation());
    
    rotationTimer = [];
    
    function startRotation()
        if isempty(rotationTimer) || ~isvalid(rotationTimer)
            rotationTimer = timer('ExecutionMode', 'fixedRate', ...
                                'Period', 0.05, ...
                                'TimerFcn', @(t,~) rotateView());
            start(rotationTimer);
        end
    end
    
    function stopRotation()
        if ~isempty(rotationTimer) && isvalid(rotationTimer)
            stop(rotationTimer);
            delete(rotationTimer);
            rotationTimer = [];
        end
    end
    
    function rotateView()
        currentView = ax.View;
        ax.View = [currentView(1) + 2, currentView(2)];
    end
    
    % 窗口关闭时清理定时器
    previewFig.CloseRequestFcn = @(src,event) closePreview();
    
    function closePreview()
        stopRotation();
        delete(previewFig);
    end
    
    % 显示模型信息
    fprintf('模型信息 - 顶点数: %d, 面数: %d\n', size(vertices, 1), size(faces, 1));
end