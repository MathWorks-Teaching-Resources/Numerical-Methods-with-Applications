% Run these tests with runMyTests
% All tests so far are on code expected to run without errors
% If/when we end up with a version that _should_ error, 
% please add it to this set of examples
classdef smokeTests < matlab.unittest.TestCase

    properties
        fc
        origProj
        openFilesIdx
    end

    methods (TestClassSetup)
        function setUpPath(testCase)
            testCase.origProj = matlab.project.rootProject;
            testCase.openFilesIdx = length(matlab.desktop.editor.getAll);
            testCase.fc = fullfile(pwd);
            rootDirName = extractBefore(testCase.fc,"tests");
            openProject(rootDirName);
        end % function setUpPath
    end % methods (TestClassSetup)

    methods(Test)

        function dataExists(testCase)
            load("hand2.mat","x","y")
            clear x y
            load("car.mat","xCar","yCar")
            clear xCar yCar
            load("drawing.mat","x","y")
            clear x y
            load("lakeData.mat","lakeX","lakeY","scale")
            clear lakeY lakeX scale
            load("modernLakeData.mat","latScale","longScale","modLakeLat","modLakeLong")
            clear latScale longScale modLakeLat modLakeLong
            load("myStorm.mat","myStorm")
            clear myStorm
        end

        function runDerivatives(testCase)
            % this function runs all the code in Functions.mlx
            % it also logs the final figure in the resulting output
            % document while closing the figure window on teardown
            import matlab.unittest.diagnostics.FigureDiagnostic;
            testCase.log("Running approximatingDerivatives.mlx")
            fig = figure;
            testCase.addTeardown(@close,fig)
            approximatingDerivatives
            testCase.log(3,FigureDiagnostic(fig))
        end

        function runInterpolation(testCase)
            % this is the simplest possible logged version of a smoke test
            % that will run a file called "SharingCode.mlx"
            testCase.log("Running interpolation.mlx")
            interpolation
        end
        function runStorms(testCase)
            testCase.log("Running track storms...")
            trackStorms
        end

        function runNumericalIntegration(testCase)
            testCase.log("Running Numerical Integration")
            numericalIntegration
        end

        function runNumODEs(testCase)
            testCase.log("Running Numerical ODEs")
            diffEqs
        end
        function runPendulum(testCase)
            testCase.log("Running pendulum...")
            flag = 0;
            try
                pendulum
            catch ME
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
                    rethrow(ME)
                end
            end
                    
        end

        function runNumPDEs(testCase)
            testCase.log("Running Numerical PDEs")
            partialDiffEqs
        end
    end

    methods (TestClassTeardown)
        function resetPath(testCase)

            if isempty(testCase.origProj)
                close(currentProject)
            else
                openProject(testCase.origProj.RootFolder)
            end
            myLastList = matlab.desktop.editor.getAll;
            if length(myLastList)>testCase.openFilesIdx
                closeNoPrompt(myLastList(testCase.openFilesIdx+1:end))
            end
            cd(testCase.fc)
            close all force
        end

    end % methods (TestClassTeardown)

end