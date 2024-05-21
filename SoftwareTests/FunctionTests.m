classdef FunctionTests < matlab.unittest.TestCase

    properties (ClassSetupParameter)
        Project = {''};
    end
    methods (TestClassSetup)

        function SetUpFunctionTest(testCase,Project)
            try
                currentProject;
            catch ME
                warning("Project is not loaded.")
            end
        end
    end % TestClassSetup

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

    end % methods

end % classdef