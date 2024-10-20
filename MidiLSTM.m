% Read midi data from file
midiData = readmidi('A., Jag, Je taime Juliette, OXC7Fd0ZN8o.mid');

deltaTime = [midiData.track(2).messages.deltatime] 
data = [midiData.track(2).messages.data] 

% To be continued:
% Prepare input-output pairs for LSTM training
X = [];
Y = [];

% Loop through the data to create sequences
X = [deltaTime];  % Input sequence of deltaTime and notePitches
Y = [];  % Output is the next note to predict
end

inputSize = 2;  % Since we are using deltaTime and notePitch
numHiddenUnits = 100;
numResponses = 1;  % Predicting the next note pitch

layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(numHiddenUnits, 'OutputMode', 'last')
    fullyConnectedLayer(numResponses)
    regressionLayer];

% Define training options
options = trainingOptions('adam', ...
    'MaxEpochs', 100, ...
    'GradientThreshold', 1, ...
    'InitialLearnRate', 0.01, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropPeriod', 10, ...
    'LearnRateDropFactor', 0.2, ...
    'Verbose', 0, ...
    'Plots', 'training-progress');

% Train the LSTM model
net = trainNetwork(X, Y, layers, options);
