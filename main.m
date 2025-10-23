function main()
    % TPMS点阵结构生成主程序
    % 创建图形用户界面
    
    % 创建主窗口
    fig = uifigure('Name', 'TPMS点阵结构生成器', ...
                  'Position', [100 50 1000 750], ...
                  'Color', [0.95 0.95 0.95]);
    
    % 创建主网格布局：左侧控制面板，右侧预览区域
    mainGrid = uigridlayout(fig, [1 2]);
    mainGrid.ColumnWidth = {'1x', '1.5x'};
    
    % 左侧控制面板
    controlPanel = uipanel(mainGrid, 'Title', '控制参数', 'FontWeight', 'bold');
    controlPanel.Layout.Row = 1;
    controlPanel.Layout.Column = 1;
    
    % 右侧预览面板
    previewPanel = uipanel(mainGrid, 'Title', '3D预览', 'FontWeight', 'bold');
    previewPanel.Layout.Row = 1;
    previewPanel.Layout.Column = 2;
    
    % 控制面板布局
    controlGrid = uigridlayout(controlPanel, [15 2]);
    controlGrid.RowHeight = {30, 30, 30, 60, 30, 30, 30, 30, 30, 30, 30, 30, 30, 75, 30, '1x'};
    controlGrid.ColumnWidth = {120, '1x'};
    
    % 存储控件句柄的结构体
    handles = struct();
    
    % TPMS类型选择 (第1行)
    label1 = uilabel(controlGrid, 'Text', 'TPMS类型:', 'FontWeight', 'bold');
    label1.Layout.Row = 1;
    label1.Layout.Column = 1;
    
    handles.tpmsType = uidropdown(controlGrid, ...
        'Items', {'Gyroid', 'Schwarz P', 'Schwarz D', 'Neovius', '自定义'}, ...
        'Value', 'Gyroid');
    handles.tpmsType.Layout.Row = 1;
    handles.tpmsType.Layout.Column = 2;
    
    % 模型类型选择 (第2行)
    label2 = uilabel(controlGrid, 'Text', '模型类型:', 'FontWeight', 'bold');
    label2.Layout.Row = 2;
    label2.Layout.Column = 1;
    
    handles.modelType = uidropdown(controlGrid, ...
        'Items', {'壳模型', '有厚度模型'}, ...
        'Value', '壳模型');
    handles.modelType.Layout.Row = 2;
    handles.modelType.Layout.Column = 2;
    
        % 模型类型选择 (第3行)
    label2 = uilabel(controlGrid, 'Text', '模型形状:', 'FontWeight', 'bold');
    label2.Layout.Row = 3;
    label2.Layout.Column = 1;
    
    handles.modelShape = uidropdown(controlGrid, ...
        'Items', {'正方形', '圆柱形'}, ...
        'Value', '正方形');
    handles.modelShape.Layout.Row = 3;
    handles.modelShape.Layout.Column = 2;

    % 自定义方程输入 (第4行)
    label3 = uilabel(controlGrid, 'Text', '自定义方程:', 'FontWeight', 'bold');
    label3.Layout.Row = 4;
    label3.Layout.Column = 1;
    
    handles.customEqn = uitextarea(controlGrid, ...
        'Value', 'cos(x) + cos(y) + cos(z)', ...
        'Visible', 'off', ...
        'Placeholder', '输入自定义方程，使用x, y, z作为变量');
    handles.customEqn.Layout.Row = 4;
    handles.customEqn.Layout.Column = 2;


    
    % 网格尺寸 (第5行)
    label4 = uilabel(controlGrid, 'Text', '网格尺寸(20-200):', 'FontWeight', 'bold');
    label4.Layout.Row = 5;
    label4.Layout.Column = 1;
    
    handles.gridSizeCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 50, 'Limits', [20 200]);
    handles.gridSizeCtrl.Layout.Row = 5;
    handles.gridSizeCtrl.Layout.Column = 2;
    

        % 等值面参数 (第6行)
    label6 = uilabel(controlGrid, 'Text', '等值面参数(-2-2):', 'FontWeight', 'bold');
    label6.Layout.Row = 6;
    label6.Layout.Column = 1;
    
    handles.isovalueCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 0, 'Limits', [-2 2]);
    handles.isovalueCtrl.Layout.Row = 6;
    handles.isovalueCtrl.Layout.Column = 2;


    % 单元尺寸 (第7行)
    handles.unitXSizeLabel = uilabel(controlGrid, 'Text', 'x方向单胞尺寸(1-50):', 'FontWeight', 'bold');
    handles.unitXSizeLabel.Layout.Row = 7;
    handles.unitXSizeLabel.Layout.Column = 1;
    
    handles.unitXSizeCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 5, 'Limits', [1 50]);
    handles.unitXSizeCtrl.Layout.Row = 7;
    handles.unitXSizeCtrl.Layout.Column = 2;

    handles.unitRSizeLabel = uilabel(controlGrid, 'Text', 'r方向单胞尺寸(1-50):', 'FontWeight', 'bold');
    handles.unitRSizeLabel.Layout.Row = 7;
    handles.unitRSizeLabel.Layout.Column = 1;
    
    handles.unitRSizeCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 5, 'Limits', [1 50]);
    handles.unitRSizeCtrl.Layout.Row = 7;
    handles.unitRSizeCtrl.Layout.Column = 2;

        % 单元尺寸 (第7行)
    handles.unitYSizeLabel = uilabel(controlGrid, 'Text', 'y方向单胞尺寸(1-50):', 'FontWeight', 'bold');
    handles.unitYSizeLabel.Layout.Row = 8;
    handles.unitYSizeLabel.Layout.Column = 1;
    
    handles.unitYSizeCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 5, 'Limits', [1 50]);
    handles.unitYSizeCtrl.Layout.Row = 8;
    handles.unitYSizeCtrl.Layout.Column = 2;

    handles.unitThetaSizeLabel = uilabel(controlGrid, 'Text', 'Theta方向单胞数(1-50):', 'FontWeight', 'bold');
    handles.unitThetaSizeLabel.Layout.Row = 10;
    handles.unitThetaSizeLabel.Layout.Column = 1;
    
    handles.unitThetaSizeCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 10, 'Limits', [1 50]);
    handles.unitThetaSizeCtrl.Layout.Row = 10;
    handles.unitThetaSizeCtrl.Layout.Column = 2;

        % 单元尺寸 (第7行)
    handles.unitZSizeLabel = uilabel(controlGrid, 'Text', 'z方向单胞尺寸(1-50):', 'FontWeight', 'bold');
    handles.unitZSizeLabel.Layout.Row = 9;
    handles.unitZSizeLabel.Layout.Column = 1;
    
    handles.unitZSizeCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 5, 'Limits', [1 50]);
    handles.unitZSizeCtrl.Layout.Row = 9;
    handles.unitZSizeCtrl.Layout.Column = 2;

    handles.unitZrSizeLabel = uilabel(controlGrid, 'Text', 'z方向单胞尺寸(1-50):', 'FontWeight', 'bold');
    handles.unitZrSizeLabel.Layout.Row = 8;
    handles.unitZrSizeLabel.Layout.Column = 1;
    
    handles.unitZrSizeCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 5, 'Limits', [1 50]);
    handles.unitZrSizeCtrl.Layout.Row = 8;
    handles.unitZrSizeCtrl.Layout.Column = 2;
   
    
    
    % 周期数 (第11行)
    handles.periodsXLabel = uilabel(controlGrid, 'Text', 'x方向周期数(1-10):', 'FontWeight', 'bold');
    handles.periodsXLabel.Layout.Row = 10;
    handles.periodsXLabel.Layout.Column = 1;
    
    handles.periodsXCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 2, 'Limits', [1 10]);
    handles.periodsXCtrl.Layout.Row = 10;
    handles.periodsXCtrl.Layout.Column = 2;
    
    handles.periodsRLabel = uilabel(controlGrid, 'Text', 'r方向周期数(1-10):', 'FontWeight', 'bold');
    handles.periodsRLabel.Layout.Row = 9;
    handles.periodsRLabel.Layout.Column = 1;
    
    handles.periodsRCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 2, 'Limits', [1 10]);
    handles.periodsRCtrl.Layout.Row = 9;
    handles.periodsRCtrl.Layout.Column = 2;

        % 周期数 (第11行)
    handles.periodsYLabel = uilabel(controlGrid, 'Text', 'y方向周期数(1-10):', 'FontWeight', 'bold');
    handles.periodsYLabel.Layout.Row = 11;
    handles.periodsYLabel.Layout.Column = 1;
    
    handles.periodsYCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 2, 'Limits', [1 10]);
    handles.periodsYCtrl.Layout.Row = 11;
    handles.periodsYCtrl.Layout.Column = 2;

    handles.periodsZrLabel = uilabel(controlGrid, 'Text', 'z方向周期数(1-10):', 'FontWeight', 'bold');
    handles.periodsZrLabel.Layout.Row = 11;
    handles.periodsZrLabel.Layout.Column = 1;
    
    handles.periodsZrCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 2, 'Limits', [1 10]);
    handles.periodsZrCtrl.Layout.Row = 11;
    handles.periodsZrCtrl.Layout.Column = 2;

        % 周期数 (第11行)
    handles.periodsZLabel = uilabel(controlGrid, 'Text', 'z方向周期数(1-10):', 'FontWeight', 'bold');
    handles.periodsZLabel.Layout.Row = 12;
    handles.periodsZLabel.Layout.Column = 1;
    
    handles.periodsZCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 2, 'Limits', [1 10]);
    handles.periodsZCtrl.Layout.Row = 12;
    handles.periodsZCtrl.Layout.Column = 2;

    handles.innerRadiusLabel = uilabel(controlGrid, 'Text', '圆柱内径(>0):', 'FontWeight', 'bold');
    handles.innerRadiusLabel.Layout.Row = 12;
    handles.innerRadiusLabel.Layout.Column = 1;
    
    handles.innerRadiusCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 5);
    handles.innerRadiusCtrl.Layout.Row = 12;
    handles.innerRadiusCtrl.Layout.Column = 2;
    
    % 厚度参数 (第13行)
    handles.thicknessLabel = uilabel(controlGrid, 'Text', '厚度参数(0.01-2):', 'FontWeight', 'bold');
    handles.thicknessLabel.Layout.Row = 13;
    handles.thicknessLabel.Layout.Column = 1;
    
    handles.thicknessCtrl = uieditfield(controlGrid, 'numeric', ...
        'Value', 0.3, 'Limits', [0.01 2]);
    handles.thicknessCtrl.Layout.Row = 13;
    handles.thicknessCtrl.Layout.Column = 2;
    
    
    % 方程示例 (第14行)
    label9 = uilabel(controlGrid, 'Text', '方程示例:', 'FontWeight', 'bold');
    label9.Layout.Row = 14;
    label9.Layout.Column = 1;
    
    exampleText = uitextarea(controlGrid, ...
        'Value', {'自定义方程示例:', ...
                 'Schwarz P: cos(x) + cos(y) + cos(z)', ...
                 '正方形使用x, y, z作为变量'...
                 '圆柱形使用r,theta,z作为变量'}, ...
        'Editable', 'off');
    exampleText.Layout.Row = 14;
    exampleText.Layout.Column = 2;
    
    % 生成按钮 (第16行)
    generateBtn = uibutton(controlGrid, ...
        'Text', '生成TPMS结构', ...
        'ButtonPushedFcn', @(btn,event) generateTPMS(), ...
        'FontWeight', 'bold', ...
        'FontColor', [1 1 1], ...
        'BackgroundColor', [0.2 0.6 0.8]);
    generateBtn.Layout.Row = 15;
    generateBtn.Layout.Column = [1 2];
    
    % 预览面板布局
    previewGrid = uigridlayout(previewPanel, [8 1]);
    previewGrid.RowHeight = {50, 80, 50, 25, 25, 25, 25, '1x'};
    
    % 预览控制按钮
    viewBtnGrid = uigridlayout(previewGrid, [1 4]);
    viewBtnGrid.Layout.Row = 1;
    viewBtnGrid.Layout.Column = 1;
    
    uibutton(viewBtnGrid, 'Text', '正视图', ...
        'ButtonPushedFcn', @(btn,event) updateView(2));
    uibutton(viewBtnGrid, 'Text', '侧视图', ...
        'ButtonPushedFcn', @(btn,event) updateView([1 0 0]));
    uibutton(viewBtnGrid, 'Text', '顶视图', ...
        'ButtonPushedFcn', @(btn,event) updateView([0 0 1]));
    uibutton(viewBtnGrid, 'Text', '等轴视图', ...
        'ButtonPushedFcn', @(btn,event) updateView(3));
    
    % 显示控制
    displayGrid = uigridlayout(previewGrid, [1 2]);
    displayGrid.Layout.Row = 2;
    displayGrid.Layout.Column = 1;
    
    %label10 = uilabel(displayGrid, 'Text', '颜色:', 'FontWeight', 'bold');
    %handles.colorDropdown = uidropdown(displayGrid, ...
    %    'Items', {'蓝色', '红色', '绿色', '灰色', '黄色'}, ...
    %   'Value', '蓝色');
    
    label11 = uilabel(displayGrid, 'Text', '透明度:', 'FontWeight', 'bold');
    handles.alphaSlider = uislider(displayGrid, ...
        'Value', 0.8, 'Limits', [0.1 1]);
    
    % 旋转控制
    rotateGrid = uigridlayout(previewGrid, [1 4]);
    rotateGrid.Layout.Row = 3;
    rotateGrid.Layout.Column = 1;
    
    uibutton(rotateGrid, 'Text', '开始旋转', ...
        'ButtonPushedFcn', @(btn,event) startRotation());
    uibutton(rotateGrid, 'Text', '停止旋转', ...
        'ButtonPushedFcn', @(btn,event) stopRotation());
    
    label12 = uilabel(rotateGrid, 'Text', '模型信息:', 'FontWeight', 'bold');
    handles.infoLabel = uilabel(rotateGrid, 'Text', '请先生成模型');
    
    % 导出按钮
    exportBtn = uibutton(previewGrid, ...
        'Text', '导出STL文件', ...
        'ButtonPushedFcn', @(btn,event) exportSTL(), ...
        'FontWeight', 'bold');
    exportBtn.Layout.Row = 4;
    exportBtn.Layout.Column = 1;
    
    % 3D预览坐标区
    handles.previewAxes = uiaxes(previewGrid);
    handles.previewAxes.Layout.Row = [5 8];
    handles.previewAxes.Layout.Column = 1;
    axis(handles.previewAxes, 'equal');
    grid(handles.previewAxes, 'on');
    xlabel(handles.previewAxes, 'X');
    ylabel(handles.previewAxes, 'Y');
    zlabel(handles.previewAxes, 'Z');
    title(handles.previewAxes, 'TPMS结构预览');
    
    % 初始化预览坐标区
    initializePreview(handles.previewAxes);
    
    % 事件回调函数
    handles.tpmsType.ValueChangedFcn = @(src,event) updateCustomEqnVisibility();
    handles.modelType.ValueChangedFcn = @(src,event) updateThicknessVisibility();
    handles.modelShape.ValueChangedFcn = @(src,event) updateShapeCtrlVisibility();
    handles.colorDropdown.ValueChangedFcn = @(src,event) updateColor();
    handles.alphaSlider.ValueChangedFcn = @(src,event) updateAlpha();
    
    % 旋转定时器
    handles.rotationTimer = [];
    
    % 嵌套函数定义
    function updateShapeCtrlVisibility()
        if strcmp(handles.modelShape.Value,'正方形')
            handles.unitXSizeCtrl.Visible = 'on';
            handles.unitYSizeCtrl.Visible = 'on';
            handles.unitZSizeCtrl.Visible = 'on';
            handles.periodsXCtrl.Visible = 'on';
            handles.periodsYCtrl.Visible = 'on';
            handles.periodsZCtrl.Visible = 'on';
            handles.unitXSizeLabel.Visible = 'on';
            handles.unitYSizeLabel.Visible = 'on';
            handles.unitZSizeLabel.Visible = 'on';
            handles.periodsXLabel.Visible = 'on';
            handles.periodsYLabel.Visible = 'on';
            handles.periodsZLabel.Visible = 'on';
            handles.unitRSizeCtrl.Visible = 'off';
            handles.unitThetaSizeCtrl.Visible = 'off';
            handles.unitZrSizeCtrl.Visible = 'off';
            handles.periodsRCtrl.Visible = 'off';
            handles.periodsZrCtrl.Visible = 'off';
            handles.unitRSizeLabel.Visible = 'off';
            handles.unitThetaSizeLabel.Visible = 'off';
            handles.unitZrSizeLabel.Visible = 'off';
            handles.periodsRLabel.Visible = 'off';
            handles.periodsZrLabel.Visible = 'off';
            handles.innerRadiusLabel.Visible = 'off';
            handles.innerRadiusCtrl.Visible = 'off';
        elseif strcmp(handles.modelShape.Value,'圆柱形')
            handles.unitXSizeCtrl.Visible = 'off';
            handles.unitYSizeCtrl.Visible = 'off';
            handles.unitZSizeCtrl.Visible = 'off';
            handles.periodsXCtrl.Visible = 'off';
            handles.periodsYCtrl.Visible = 'off';
            handles.periodsZCtrl.Visible = 'off';
            handles.unitXSizeLabel.Visible = 'off';
            handles.unitYSizeLabel.Visible = 'off';
            handles.unitZSizeLabel.Visible = 'off';
            handles.periodsXLabel.Visible = 'off';
            handles.periodsYLabel.Visible = 'off';
            handles.periodsZLabel.Visible = 'off';
            handles.unitRSizeCtrl.Visible = 'on';
            handles.unitThetaSizeCtrl.Visible = 'on';
            handles.unitZrSizeCtrl.Visible = 'on';
            handles.periodsRCtrl.Visible = 'on';
            handles.periodsZrCtrl.Visible = 'on';
            handles.unitRSizeLabel.Visible = 'on';
            handles.unitThetaSizeLabel.Visible = 'on';
            handles.unitZrSizeLabel.Visible = 'on';
            handles.periodsRLabel.Visible = 'on';
            handles.periodsZrLabel.Visible = 'on';
            handles.innerRadiusLabel.Visible = 'on';
            handles.innerRadiusCtrl.Visible = 'on';
        end

    end

    function updateCustomEqnVisibility()
        if strcmp(handles.tpmsType.Value, '自定义')
            handles.customEqn.Visible = 'on';
        else
            handles.customEqn.Visible = 'off';
        end
    end
    
    function updateThicknessVisibility()
        if strcmp(handles.modelType.Value, '有厚度模型')
            handles.thicknessLabel.Visible = 'on';
            handles.thicknessCtrl.Visible = 'on';
        else
            handles.thicknessLabel.Visible = 'off';
            handles.thicknessCtrl.Visible = 'off';
        end
    end
    
    function updateView(viewAngle)
        if ishandle(handles.previewAxes)
            view(handles.previewAxes, viewAngle);
        end
    end
    
    function updateColor()
        if isfield(handles, 'patchHandle') && ishandle(handles.patchHandle)
            colors = struct('蓝色', [0.8 0.8 1.0], ...
                           '红色', [1.0 0.8 0.8], ...
                           '绿色', [0.8 1.0 0.8], ...
                           '灰色', [0.7 0.7 0.7], ...
                           '黄色', [1.0 1.0 0.8]);
            handles.patchHandle.FaceColor = colors.(handles.colorDropdown.Value);
        end
    end
    
    function updateAlpha()
        if isfield(handles, 'patchHandle') && ishandle(handles.patchHandle)
            handles.patchHandle.FaceAlpha = handles.alphaSlider.Value;
        end
    end
    
    function startRotation()
        if isempty(handles.rotationTimer) || ~isvalid(handles.rotationTimer)
            handles.rotationTimer = timer('ExecutionMode', 'fixedRate', ...
                                        'Period', 0.05, ...
                                        'TimerFcn', @(t,~) rotateView());
            start(handles.rotationTimer);
        end
    end
    
    function stopRotation()
        if ~isempty(handles.rotationTimer) && isvalid(handles.rotationTimer)
            stop(handles.rotationTimer);
            delete(handles.rotationTimer);
            handles.rotationTimer = [];
        end
    end
    
    function rotateView()
        if ishandle(handles.previewAxes)
            currentView = handles.previewAxes.View;
            handles.previewAxes.View = [currentView(1) + 2, currentView(2)];
        end
    end
    
    function generateTPMS()
        
        try
            if strcmp(handles.modelShape.Value,'正方形')
                % 获取参数
                gridSize = handles.gridSizeCtrl.Value;
                unitXSize = handles.unitXSizeCtrl.Value;
                unitYSize = handles.unitYSizeCtrl.Value;
                unitZSize = handles.unitZSizeCtrl.Value;
                isovalue = handles.isovalueCtrl.Value;
                periodsX = handles.periodsXCtrl.Value;
                periodsY = handles.periodsYCtrl.Value;
                periodsZ = handles.periodsZCtrl.Value;
                
                % 选择TPMS方程
                switch handles.tpmsType.Value
                    case 'Gyroid'
                        equation = @(x,y,z) cos(2*pi*x/(unitXSize*periodsX)*periodsX) .* sin(2*pi*y/(unitYSize*periodsY)*periodsY) + ...
                                           cos(2*pi*y/(unitYSize*periodsY)*periodsY) .* sin(2*pi*z/(unitZSize*periodsZ)*periodsZ) + ...
                                           cos(2*pi*z/(unitZSize*periodsZ)*periodsZ) .* sin(2*pi*x/(unitXSize*periodsX)*periodsX);
                    case 'Schwarz P'
                        equation = @(x,y,z) cos(2*pi*x/(unitXSize*periodsX)*periodsX) + cos(2*pi*y/(unitYSize*periodsY)*periodsY) + cos(2*pi*z/(unitZSize*periodsZ)*periodsZ);
                    case 'Schwarz D'
                        equation = @(x,y,z) sin(2*pi*x/(unitXSize*periodsX)*periodsX) .* sin(2*pi*y/(unitYSize*periodsY)*periodsY) .* sin(2*pi*z/(unitZSize*periodsZ)*periodsZ) + ...
                                           sin(2*pi*x/(unitXSize*periodsX)*periodsX) .* cos(2*pi*y/(unitYSize*periodsY)*periodsY) .* cos(2*pi*z/(unitZSize*periodsZ)*periodsZ) + ...
                                           cos(2*pi*x/(unitXSize*periodsX)*periodsX) .* sin(2*pi*y/(unitYSize*periodsY)*periodsY) .* cos(2*pi*z/(unitZSize*periodsZ)*periodsZ) + ...
                                           cos(2*pi*x/(unitXSize*periodsX)*periodsX) .* cos(2*pi*y/(unitYSize*periodsY)*periodsY) .* sin(2*pi*z/(unitZSize*periodsZ)*periodsZ);
                    case 'Neovius'
                        equation = @(x,y,z) 3*(cos(2*pi*x/(unitXSize*periodsX)*periodsX) + cos(2*pi*y/(unitYSize*periodsY)*periodsY) + cos(2*pi*z/(unitZSize*periodsZ)*periodsZ)) + ...
                                           4*cos(2*pi*x/(unitXSize*periodsX)*periodsX).*cos(2*pi*y/(unitYSize*periodsY)*periodsY).*cos(2*pi*z/(unitZSize*periodsZ)*periodsZ);
                    case '自定义'
                        eqnStr = handles.customEqn.Value;
                        % 为自定义方程添加单位标准化
                        equation = @(x,y,z) evalCustomEquation(eqnStr, x, y, z, unitXSize, unitYSize, unitZSize, periodsX, periodsY, periodsZ);
                end
                
                % 生成模型
                if strcmp(handles.modelType.Value, '壳模型')
                    [vertices, faces] = generateShellModel(equation, gridSize, unitXSize, unitYSize, unitZSize, periodsX, periodsY, periodsZ , isovalue);
                else
                    thickness = handles.thicknessCtrl.Value;
                    [vertices, faces] = generateThickModel(equation, gridSize, unitXSize, unitYSize, unitZSize,  periodsX, periodsY, periodsZ ,isovalue, thickness);
                end
            else 
                % 获取参数
                gridSize = handles.gridSizeCtrl.Value;
                unitRSize = handles.unitRSizeCtrl.Value;
                unitThetaSize = handles.unitThetaSizeCtrl.Value;
                unitZrSize = handles.unitZrSizeCtrl.Value;
                isovalue = handles.isovalueCtrl.Value;
                periodsR = handles.periodsRCtrl.Value;
                periodsZr = handles.periodsZrCtrl.Value;
                innerRadius = handles.innerRadiusCtrl.Value;
                
                % 选择TPMS方程
                switch handles.tpmsType.Value
                    case 'Gyroid'
                        equation = @(r,theta,z) cos(2*pi*r/(unitRSize*periodsR)*periodsR) .* sin(theta*unitThetaSize) + ...
                                           cos(theta*unitThetaSize) .* sin(2*pi*z/(unitZrSize*periodsZr)*periodsZr) + ...
                                           cos(2*pi*z/(unitZrSize*periodsZr)*periodsZr) .* sin(2*pi*r/(unitRSize*periodsR)*periodsR);
                    case 'Schwarz P'
                        equation = @(r,theta,z) cos(2*pi*r/(unitRSize*periodsR)*periodsR) + cos(theta*unitThetaSize) + cos(2*pi*z/(unitZrSize*periodsZr)*periodsZr);
                    case 'Schwarz D'
                        equation = @(r,theta,z) sin(2*pi*r/(unitRSize*periodsR)*periodsR) .* sin(theta*unitThetaSize) .* sin(2*pi*z/(unitZrSize*periodsZr)*periodsZr) + ...
                                           sin(2*pi*r/(unitRSize*periodsR)*periodsR) .* cos(theta*unitThetaSize) .* cos(2*pi*z/(unitZrSize*periodsZr)*periodsZr) + ...
                                           cos(2*pi*r/(unitRSize*periodsR)*periodsR) .* sin(theta*unitThetaSize) .* cos(2*pi*z/(unitZrSize*periodsZr)*periodsZr) + ...
                                           cos(2*pi*r/(unitRSize*periodsR)*periodsR) .* cos(theta*unitThetaSize) .* sin(2*pi*z/(unitZrSize*periodsZr)*periodsZr);
                    case 'Neovius'
                        equation = @(r,theta,z) 3*(cos(2*pi*r/(unitRSize*periodsR)*periodsR) + cos(theta*unitThetaSize) + cos(2*pi*z/(unitZrSize*periodsZr)*periodsZr)) + ...
                                           4*cos(2*pi*r/(unitRSize*periodsR)*periodsR).*cos(theta*unitThetaSize).*cos(2*pi*z/(unitZrSize*periodsZr)*periodsZr);
                    case '自定义'
                        eqnStr = handles.customEqn.Value;
                        % 为自定义方程添加单位标准化
                        equation = @(r,theta,z) evalCylinderCustomEquation(eqnStr, r, theta, z, unitRSize, unitThetaSize, unitZrSize, periodsR, periodsZr);
                end
                
                % 生成模型
                if strcmp(handles.modelType.Value, '壳模型')
                    [vertices, faces] = generateCylinderShellModel(equation, gridSize, unitRSize, unitThetaSize, unitZrSize, periodsR,  periodsZr , innerRadius , isovalue);
                else
                    thickness = handles.thicknessCtrl.Value;
                    [vertices, faces] = generateCylinderThickModel(equation, gridSize, unitRSize, unitThetaSize, unitZrSize,  periodsR, periodsZr , innerRadius , isovalue, thickness);
                end
            end
            % 保存数据到基础工作区
            assignin('base', 'tpms_vertices', vertices);
            assignin('base', 'tpms_faces', faces);
            assignin('base', 'tpms_equation', equation);
            
            % 更新预览
            updatePreview(vertices, faces);
            
            % 更新信息标签
            infoText = sprintf('顶点: %d, 面: %d', size(vertices, 1), size(faces, 1));
            handles.infoLabel.Text = infoText;
            
            uialert(fig, 'TPMS结构生成成功！', '成功');
            
        catch ME
            uialert(fig, sprintf('生成失败: %s', ME.message), '错误');
        end
    end
    
    function updatePreview(vertices, faces)
        % 清除之前的图形
        cla(handles.previewAxes);
        
        % 绘制新模型
        handles.patchHandle = patch(handles.previewAxes, 'Faces', faces, 'Vertices', vertices, ...
              'FaceColor', [0.8 0.8 1.0], ...
              'EdgeColor', 'none', ...
              'FaceAlpha', 0.8);
        
        % 设置坐标区属性
        axis(handles.previewAxes, 'equal');
        grid(handles.previewAxes, 'on');
        xlabel(handles.previewAxes, 'X');
        ylabel(handles.previewAxes, 'Y');
        zlabel(handles.previewAxes, 'Z');
        title(handles.previewAxes, 'TPMS结构预览');
        
        % 添加光照
        light(handles.previewAxes, 'Position', [1 1 1]);
        lighting(handles.previewAxes, 'gouraud');
        material(handles.previewAxes, 'dull');
        
        % 更新视图
        view(handles.previewAxes, 3);
    end
    
    function initializePreview(ax)
        % 初始化预览区域显示提示信息
        cla(ax);
        text(ax, 0.5, 0.5, 0.5, '请先生成TPMS结构', ...
             'HorizontalAlignment', 'center', ...
             'VerticalAlignment', 'middle', ...
             'FontSize', 14, ...
             'FontWeight', 'bold');
        axis(ax, 'off');
    end
    
    function exportSTL()
        % 导出STL文件
        try
            vertices = evalin('base', 'tpms_vertices');
            faces = evalin('base', 'tpms_faces');
            
            [filename, pathname] = uiputfile('*.stl', '保存STL文件');
            if filename ~= 0
                fullpath = fullfile(pathname, filename);
                exportSTLFile(vertices, faces, fullpath);
                uialert(fig, sprintf('STL文件已保存至: %s', fullpath), '导出成功');
            end
        catch
            uialert(fig, '请先生成TPMS结构！', '错误');
        end
    end
    
    % 窗口关闭时清理定时器
    fig.CloseRequestFcn = @(src,event) closeApp();
    
    function closeApp()
        stopRotation();
        delete(fig);
    end
    
    % 初始更新
    updateCustomEqnVisibility();
    updateThicknessVisibility();
    updateShapeCtrlVisibility();
end

function result = evalCustomEquation(eqnStr, x, y, z, unitXSize, unitYSize, unitZSize, periodsX, periodsY, periodsZ)
    % 安全地评估自定义方程
    % 创建局部变量用于评估
    x_norm = x / (unitXSize*periodsX) * 2 * pi * periodsX;
    y_norm = y / (unitYSize*periodsY) * 2 * pi * periodsY;
    z_norm = z / (unitZSize*periodsZ) * 2 * pi * periodsZ;
    
    % 评估表达式
    try
        eqnStr = char(eqnStr);
        funcHandle = str2func(['@(x,y,z)' eqnStr]);
        result = funcHandle(x_norm, y_norm, z_norm);
    catch ME
        error('自定义方程格式错误，请检查方程语法。错误信息: %s', ME.message);
    end
end

function result = evalCylinderCustomEquation(eqnStr, r, theta, z, unitRSize, unitThetaSize, unitZrSize, periodsR, periodsZr)
    % 安全地评估自定义方程
    % 创建局部变量用于评估
    r_norm = r / (unitRSize* periodsR) * 2 * pi * periodsR;
    theta_norm = theta * unitThetaSize;
    z_norm = z / (unitZrSize * periodsZr) * 2 * pi * periodsZr;
    
    % 评估表达式
    try
        eqnStr = char(eqnStr);
        funcHandle = str2func(['@(r,theta,z)' eqnStr]);
        result = funcHandle(r_norm, theta_norm, z_norm);
    catch ME
        error('自定义方程格式错误，请检查方程语法。错误信息: %s', ME.message);
    end
end