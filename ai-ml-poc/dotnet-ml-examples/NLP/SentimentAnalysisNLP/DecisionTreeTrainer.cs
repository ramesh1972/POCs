using SentimentAnalysisMlNet.MachineLearning.Common;
using Microsoft.ML;
using Microsoft.ML.Calibrators;
using Microsoft.ML.Trainers.FastTree;

namespace SentimentAnalysisMlNet.MachineLearning.Trainers
{
    public class DecisionTreeTrainer : TrainerBase<
                      CalibratedModelParametersBase<FastTreeBinaryModelParameters, PlattCalibrator>>
    {
        public DecisionTreeTrainer(int numberOfLeaves, int numberOfTrees, double learningRate = 0.2)
	: base()
        {
            Name = $"Decision Tree-{numberOfLeaves}-{numberOfTrees}-{learningRate}";
            _model = MlContext.BinaryClassification.Trainers.FastTree(numberOfLeaves: numberOfLeaves,
								      numberOfTrees: numberOfTrees,
								      learningRate: learningRate);
        }
    }
}
