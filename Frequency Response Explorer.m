classdef FreqResponseApp < matlab.apps.AppBase

    % Properties
    properties (Access = public)
        UIFigure             matlab.ui.Figure
        SystemTypeDropDown   matlab.ui.control.DropDown
        SystemTypeLabel      matlab.ui.control.Label
        NumLabel             matlab.ui.control.Label
        NumEditField         matlab.ui.control.EditField
        DenLabel             matlab.ui.control.Label
        DenEditField         matlab.ui.control.EditField
        HLabel               matlab.ui.control.Label
        HEditField           matlab.ui.control.EditField

        PlotButton           matlab.ui.control.Button
        MagAxes              matlab.ui.control.UIAxes
        PhaseAxes            matlab.ui.control.UIAxes
        % New components for frequency range
        FreqRangeLabel       matlab.ui.control.Label
        FreqMinEditField     matlab.ui.control.NumericEditField
        FreqMaxEditField     matlab.ui.control.NumericEditField
        ToLabel              matlab.ui.control.Label
        PointsLabel          matlab.ui.control.Label
        PointsEditField      matlab.ui.control.NumericEditField
    end

    methods (Access = private)

        % Button pushed function
        function PlotButtonPushed(app, event)
            sysType = app.SystemTypeDropDown.Value;
            
            % Get frequency range parameters
            freqMin = app.FreqMinEditField.Value;
            freqMax = app.FreqMaxEditField.Value;
            nPoints = app.PointsEditField.Value;
            
            % Validate frequency range
            if freqMin >= freqMax
                uialert(app.UIFigure, 'Maximum frequency must be greater than minimum frequency.', 'Invalid Frequency Range');
                return;
            end
            
            % Create frequency vector in the specified range
            w = linspace(freqMin*pi, freqMax*pi, nPoints);
            
            if strcmp(sysType,'Transfer Function (num/den)')
                num = str2num(app.NumEditField.Value); %#ok<ST2NM>
                den = str2num(app.DenEditField.Value);
                h = freqz(num, den, w);
            else
                h_coeff = str2num(app.HEditField.Value); %#ok<ST2NM>
                h = freqz(h_coeff, 1, w);
            end

            % Plot Magnitude
            plot(app.MagAxes,w/pi,abs(h),'Color',[0 0.5 0],'LineWidth',1.5);
            xlabel(app.MagAxes, 'Normalized Frequency (\times \pi rad/sample)');
            ylabel(app.MagAxes, '|H(\omega)|');
            title(app.MagAxes, 'Magnitude Response');
            grid(app.MagAxes, 'on');
            
            % Set x-axis limits to match the selected range
            xlim(app.MagAxes, [freqMin, freqMax]);

            % Plot Phase
            plot(app.PhaseAxes,w/pi,angle(h),'Color',[0.85 0.33 0.1],'LineWidth',1.5);
            xlabel(app.PhaseAxes, 'Normalized Frequency (\times \pi rad/sample)');
            ylabel(app.PhaseAxes, 'Phase (rad)');
            title(app.PhaseAxes, 'Phase Response');
            grid(app.PhaseAxes, 'on');
            
            % Set x-axis limits to match the selected range
            xlim(app.PhaseAxes, [freqMin, freqMax]);
        end

        % Change visible fields based on system type
        function SystemTypeChanged(app, event)
            sysType = app.SystemTypeDropDown.Value;
            if strcmp(sysType,'Transfer Function (num/den)')
                app.NumLabel.Visible = true;
                app.NumEditField.Visible = true;
                app.DenLabel.Visible = true;
                app.DenEditField.Visible = true;
                app.HLabel.Visible = false;
                app.HEditField.Visible = false;
            else
                app.NumLabel.Visible = false;
                app.NumEditField.Visible = false;
                app.DenLabel.Visible = false;
                app.DenEditField.Visible = false;
                app.HLabel.Visible = true;
                app.HEditField.Visible = true;
            end
        end
    end

    % Component creation
    methods (Access = private)

        % Create UI components
        function createComponents(app)

            % UIFigure
            app.UIFigure = uifigure('Name', 'Frequency Response Explorer');
            app.UIFigure.Position = [100 100 800 650]; % Increased height to accommodate new controls
            app.UIFigure.Color = [0.95 0.95 0.97]; 

            % System Type Dropdown
            app.SystemTypeLabel = uilabel(app.UIFigure, 'Text', 'System Representation:');
            app.SystemTypeLabel.Position = [20 610 150 30];
            app.SystemTypeLabel.FontColor = [0.1 0.1 0.1];
            app.SystemTypeDropDown = uidropdown(app.UIFigure,...
                'Items', {'Transfer Function (num/den)', 'Impulse Response (h[n])'},...
                'Position', [180 615 220 25],...
                'Value', 'Transfer Function (num/den)');
            app.SystemTypeDropDown.ValueChangedFcn = @(dd,event) SystemTypeChanged(app,event);

            % Numerator
            app.NumLabel = uilabel(app.UIFigure, 'Text', 'Numerator Coefficients:');
            app.NumLabel.Position = [20 560 150 30];
            app.NumLabel.FontColor = [0.1 0.1 0.1];
            app.NumEditField = uieditfield(app.UIFigure, 'text');
            app.NumEditField.Position = [180 565 200 25];
            app.NumEditField.Value = '[1 0.5]';

            % Denominator
            app.DenLabel = uilabel(app.UIFigure, 'Text', 'Denominator Coefficients:');
            app.DenLabel.Position = [400 560 160 30];
            app.DenLabel.FontColor = [0.1 0.1 0.1];
            app.DenEditField = uieditfield(app.UIFigure, 'text');
            app.DenEditField.Position = [570 565 200 25];
            app.DenEditField.Value = '[1 -0.3]';

            % Impulse Response
            app.HLabel = uilabel(app.UIFigure, 'Text', 'Impulse Response h[n]:');
            app.HLabel.Position = [20 560 150 30];
            app.HEditField = uieditfield(app.UIFigure, 'text');
            app.HEditField.Position = [180 565 200 25];
            app.HLabel.FontColor = [0.1 0.1 0.1];
            app.HEditField.Value = '[1 2 3 0 -1]';
            app.HLabel.Visible = false;
            app.HEditField.Visible = false;
            
            % Frequency Range Controls
            app.FreqRangeLabel = uilabel(app.UIFigure, 'Text', 'Frequency Range:');
            app.FreqRangeLabel.Position = [20 510 120 30];
            app.FreqRangeLabel.FontColor = [0.1 0.1 0.1];
            
            app.FreqMinEditField = uieditfield(app.UIFigure, 'numeric');
            app.FreqMinEditField.Position = [150 515 60 25];
            app.FreqMinEditField.Value = 0;
            app.FreqMinEditField.Limits = [0 100];
            
            app.ToLabel = uilabel(app.UIFigure, 'Text', 'to');
            app.ToLabel.Position = [220 510 20 30];
            app.ToLabel.FontColor = [0.1 0.1 0.1];
            
            app.FreqMaxEditField = uieditfield(app.UIFigure, 'numeric');
            app.FreqMaxEditField.Position = [240 515 60 25];
            app.FreqMaxEditField.Value = 1;
            app.FreqMaxEditField.Limits = [0 100];
            
            app.PointsLabel = uilabel(app.UIFigure, 'Text', 'Points:');
            app.PointsLabel.Position = [320 510 50 30];
            app.PointsLabel.FontColor = [0.1 0.1 0.1];
            
            app.PointsEditField = uieditfield(app.UIFigure, 'numeric');
            app.PointsEditField.Position = [370 515 60 25];
            app.PointsEditField.Value = 512;
            app.PointsEditField.Limits = [10 10000];

            % Plot Button
            app.PlotButton = uibutton(app.UIFigure, 'push', 'Text', 'Plot Response');
            app.PlotButton.Position = [350 460 120 30];
            app.PlotButton.BackgroundColor = [0.2 0.4 0.7]; % professional navy blue
            app.PlotButton.FontColor = [1 1 1];
            app.PlotButton.FontWeight = 'bold';
            app.PlotButton.ButtonPushedFcn = @(btn,event) PlotButtonPushed(app,event);
            
            % Magnitude Axes
            app.MagAxes = uiaxes(app.UIFigure);
            app.MagAxes.Color = [1 1 1]; 
            app.MagAxes.GridColor = [0.7 0.7 0.7];
            app.MagAxes.XColor = [0.2 0.2 0.2];
            app.MagAxes.YColor = [0.2 0.2 0.2];
            app.MagAxes.Position = [50 250 700 200];
            title(app.MagAxes, 'Magnitude Response');

            % Phase Axes
            app.PhaseAxes = uiaxes(app.UIFigure);
            app.PhaseAxes.Color = [1 1 1];
            app.PhaseAxes.GridColor = [0.7 0.7 0.7];
            app.PhaseAxes.XColor = [0.2 0.2 0.2];
            app.PhaseAxes.YColor = [0.2 0.2 0.2];
            app.PhaseAxes.Position = [50 20 700 200];
            title(app.PhaseAxes, 'Phase Response');

            zoom(app.UIFigure, 'on');
            pan(app.UIFigure, 'on');
        end
    end

    % App start
    methods (Access = public)
        function app = FreqResponseApp
            createComponents(app)
            registerApp(app, app.UIFigure)
        end
    end
end

































%plot(app.MagAxes, w/pi, abs(h), 'o', 'MarkerSize', 3, 'LineWidth', 1.5);
