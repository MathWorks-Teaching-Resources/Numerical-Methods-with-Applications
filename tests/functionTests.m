% Run these tests with runMyTests
%
% Alternately, run these tests with 
% results = runtests(tests)
% table(results)
classdef functionTests < matlab.unittest.TestCase

    methods(Test)
        function checkStartup(testCase)
            Startup
        end

        function checkOverview(testCase)
            OpenOverview
        end

    end % methods

end % classdef