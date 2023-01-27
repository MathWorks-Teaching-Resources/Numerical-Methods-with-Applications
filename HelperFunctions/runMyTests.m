import matlab.unittest.plugins.TestReportPlugin;

runner = matlab.unittest.TestRunner.withTextOutput;
runner.addPlugin(TestReportPlugin.producingHTML('Verbosity',3))

results = runner.run(testsuite("tests"))

T = table(results)

% Alternate Option using runtests() rather than testsuite()
% Because this one will not create the HTML output, it logs to a 
% diary file

% loc = pwd;
% pat = lettersPattern + textBoundary("end");
% fileName = extract(loc,pat);
% diaryName = strcat(fileName + "TestOutput");
% diary(diaryName)
% results1 = runtests("smokeTests")
% results2 = runtests("functionTests")
% diary("off")
% T = table([results1,results2])