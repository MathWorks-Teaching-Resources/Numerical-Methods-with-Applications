classdef SmokeTests < matlab.unittest.TestCase

    properties (ClassSetupParameter)
        Project = {''};
    end

    properties (TestParameter)
        Scripts;
    end

    methods (TestParameterDefinition,Static)

        function Scripts = GetScriptName(Project)
            RootFolder = currentProject().RootFolder;
            Scripts = dir(fullfile(RootFolder,"Scripts","*.mlx"));
            Scripts = {Scripts.name};
        end

    end

    methods (TestClassSetup)

        function SetUpSmokeTest(testCase,Project)
            try
                currentProject;
            catch ME
                warning("Project is not loaded.")
            end
        end


    end



    methods(Test)

        function SmokeRun(testCase,Scripts)
            Filename = string(Scripts);
            switch (Filename)
                case "Hand.mlx"
                    disp("Check Hand.mlx by hand because of data collection.")
                    testCase.verifyTrue(true)
                case "ImplementExplicitSolver.mlx"
                %    ErrorSmokeTest(testCase,Filename)
                case "PendulumModels.mlx"
                %    ErrorSmokeTest(testCase,Filename)
                case "MeasureLakeArea.mlx"
                    SmokeTestWithData(testCase,Filename)
                otherwise
                %    SimpleSmokeTest(testCase,Filename)
            end
        end

    end


    methods (Access = private)

        function SmokeTestWithData(testCase,Filename)
            % Run the Smoke test
            RootFolder = currentProject().RootFolder;
            cd(RootFolder)
            load lakeData.mat lakeX lakeY
            [~,idx] = max(diff(lakeX));
            x = lakeX([idx:end 1:idx-1]);
            y = lakeY([idx:end 1:idx-1]);
            p.Position = [x y];
            drawpolygon = p; %#ok<NASGU>
            openfig = @(in)figure;
            disp(">> Running " + Filename);
            disp("Note: run this file by hand to check on data collection and openfig()")
            try
                disp("In 'try'...")
                run(fullfile("Scripts",Filename));
                disp("Finished 'try'...")
            catch ME
                disp("In 'catch' now...")
                testCase.verifyTrue(false,ME.message);
            end
            % Log the opened figures to the test reports
            Figures = findall(groot,'Type','figure');
            Figures = flipud(Figures);
            if ~isempty(Figures)
                for f = 1:size(Figures,1)
                    FigDiag = matlab.unittest.diagnostics.FigureDiagnostic(Figures(f));
                    log(testCase,1,FigDiag);
                end
            end
            close all

        end


        function ErrorSmokeTest(testCase,Filename)

            % Run the Smoke test
            RootFolder = currentProject().RootFolder;
            cd(RootFolder)
            disp(">> Running " + Filename);
            try
                flag = 0;
                run(fullfile("Scripts",Filename));
            catch ME
                MEFlag = 1;
                switch Filename
                    case "PendulumModels.mlx"
                        if string(ME.identifier) == "MATLAB:unassignedOutputs"
                            flag = flag+1;
                            switch flag
                                case 1
                                    [t2,theta2] = ode45(@(t,theta) model2t(t,theta,L,g),[t0 tEnd],[theta0 omega0]);
                                case 2
                                    [t3,theta3] = ode45(@(t,theta) model3t(t,theta,L,g,M,b,c),[t0 tEnd],[theta0 omega0]);
                                case 3
                                    [t4,theta4] = ode45(@(t,theta) model4t(t,theta,L,g,M,m,b,c),[t0 tEnd],[theta0 omega0]);
                            end
                        else
                            MEFlag = 0;
                        end
                    case "ImplementExplicitSolver.mlx"
                        if string(ME.message) == "Index in position 1 exceeds array bounds."
                            disp("Expected error")
                        else
                            MEFlag = 0;
                        end
                    otherwise
                        testCase.verifyTrue(false,"Unexpected file in ErrorSmokeTest")
                end

                if MEFlag == 0
                    testCase.verifyTrue(false,ME.message);
                end
            end

            % Log the opened figures to the test reports
            Figures = findall(groot,'Type','figure');
            Figures = flipud(Figures);
            if ~isempty(Figures)
                for f = 1:size(Figures,1)
                    FigDiag = matlab.unittest.diagnostics.FigureDiagnostic(Figures(f));
                    log(testCase,1,FigDiag);
                end
            end
            close all

        end


        function SimpleSmokeTest(testCase,Filename)

            % Run the Smoke test
            RootFolder = currentProject().RootFolder;
            cd(RootFolder)
            disp(">> Running " + Filename);
            try
                run(fullfile("Scripts",Filename));
            catch ME
                testCase.verifyTrue(false,ME.message);
            end

            % Log the opened figures to the test reports
            Figures = findall(groot,'Type','figure');
            Figures = flipud(Figures);
            if ~isempty(Figures)
                for f = 1:size(Figures,1)
                    FigDiag = matlab.unittest.diagnostics.FigureDiagnostic(Figures(f));
                    log(testCase,1,FigDiag);
                end
            end
            close all

        end

    end

    methods (TestClassTeardown)

        function closeAllFigure(testCase)
            close all force  % Close figure windows
        end

    end % methods (TestClassTeardown)

end