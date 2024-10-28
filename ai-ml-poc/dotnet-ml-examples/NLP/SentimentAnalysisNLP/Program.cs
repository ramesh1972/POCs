
using Microsoft.ML;
using Microsoft.ML.Data;
using SentimentAnalysisMlNet.MachineLearning.Common;
using SentimentAnalysisMlNet.MachineLearning.DataModels;
using SentimentAnalysisMlNet.MachineLearning.Predictors;
using SentimentAnalysisMlNet.MachineLearning.Trainers;
using System;
using System.Collections.Generic;

namespace SentimentAnalysisMlNet
{
    class Program
    {
        static void Main(string[] args)
        {
            var newSample = new SentimentData
            {
                Text = "This is awesome!"
            };

            var trainers = new List<ITrainerBase>
            {
                new DecisionTreeTrainer(5, 10),
                new DecisionTreeTrainer(5, 10, 0.1),
                new DecisionTreeTrainer(10, 20),
                new DecisionTreeTrainer(10, 20, 0.1)
            };

            trainers.ForEach(t => TrainEvaluatePredict(t, newSample));
        }

        static void TrainEvaluatePredict(ITrainerBase trainer, SentimentData newSample)
        {
            Console.WriteLine("*******************************");
            Console.WriteLine($"{ trainer.Name }");
            Console.WriteLine("*******************************");

            trainer.Fit("Data\\sentiment labelled sentences\\imdb_labelled.txt");

            var modelMetrics = trainer.Evaluate();

            Console.WriteLine(modelMetrics.ConfusionMatrix.GetFormattedConfusionTable());
            Console.WriteLine(modelMetrics.AreaUnderRocCurve);

            Console.WriteLine($"Accuracy: {modelMetrics.Accuracy:0.##}{Environment.NewLine}" +
                              $"F1 Score: {modelMetrics.F1Score:#.##}{Environment.NewLine}" +
                              $"Positive Precision: {modelMetrics.PositivePrecision:#.##}{Environment.NewLine}" +
                              $"Negative Precision: {modelMetrics.NegativePrecision:0.##}{Environment.NewLine}" +
                              $"Positive Recall: {modelMetrics.PositiveRecall:#.##}{Environment.NewLine}" +
                              $"Negative Recall: {modelMetrics.NegativeRecall:#.##}{Environment.NewLine}" +
                              $"Area Under Precision Recall Curve: {modelMetrics.AreaUnderPrecisionRecallCurve:#.##}{Environment.NewLine}");

            trainer.Save();

            var predictor = new Predictor();
            var prediction = predictor.Predict(newSample);
            Console.WriteLine("------------------------------");
            Console.WriteLine($"Prediction: {prediction.Prediction:#.##}");
            Console.WriteLine($"Probability: {prediction.Probability:#.##}");
            Console.WriteLine("------------------------------");
        }
    }
}


namespace SentimentAnalysisMlNet.MachineLearning.DataModels
{
    public class SentimentData
    {
        [LoadColumn(0)] public string? Text;
        [LoadColumn(1), ColumnName("Label")] public bool Sentiment;
    }

    public class SentimentPrediction : SentimentData
    {
        [ColumnName("PredictedLabel")] public bool Prediction { get; set; }
        public float Probability { get; set; }
        public float Score { get; set; }
    }
}