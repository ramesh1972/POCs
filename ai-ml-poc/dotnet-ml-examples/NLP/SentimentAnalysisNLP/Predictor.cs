using SentimentAnalysisMlNet.MachineLearning.DataModels;
using Microsoft.ML;
using Microsoft.ML.Calibrators;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using Microsoft.ML.Transforms;
using System;
using System.IO;

namespace SentimentAnalysisMlNet.MachineLearning.Predictors
{
    public class Predictor
    {
        protected static string ModelPath => Path.Combine(AppContext.BaseDirectory, "classification.mdl");
        private readonly MLContext _mlContext;

        private ITransformer _model;

        public Predictor()
        {
            _mlContext = new MLContext(111);
        }

        /// <summary>
        /// Runs prediction on new data.
        /// </summary>
        /// <param name="newSample">New data sample.</param>
        /// <returns>An object which contains predictions made by model.</returns>
        public SentimentPrediction Predict(SentimentData newSample)
        {
            LoadModel();

            var predictionEngine = _mlContext.Model.
            CreatePredictionEngine<SentimentData, SentimentPrediction>(_model);

            return predictionEngine.Predict(newSample);
        }

        private void LoadModel()
        {
            if (!File.Exists(ModelPath))
            {
                throw new FileNotFoundException($"File {ModelPath} doesn't exist.");
            }

            using (var stream = new FileStream(ModelPath,
                                    FileMode.Open, 
                                FileAccess.Read,
                                FileShare.Read))
            {
                _model = _mlContext.Model.Load(stream, out _);
            }

            if (_model == null)
            {
                throw new Exception($"Failed to load Model");
            }
        }
    }
}

