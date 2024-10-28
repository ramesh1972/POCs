using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace EntityFrameworkData
{
    class Program
    {
        private static IEnumerable<SalaryData> data;

        static void Main(string[] args)
        {
            // Step 1: Prepare Data
            var fileData = ReadFromFile("./SalaryData.csv");

            data = WriteAndReadToDatabase(fileData);

            var context = new MLContext();

            var mlData = context.Data.LoadFromEnumerable(data);

            // Step 2: Split data for training and evaluation
            var trainTestData = context.Regression.TrainTestSplit(mlData);

            // Step 3: create the ML Pipeline - transform, label et.... and the acutal training algo
            var pipeline = context.Transforms.Concatenate("Features", "YearsExperience")
                .Append(context.Transforms.CopyColumns(("Label", "Salary")))
                .Append(context.Regression.Trainers.FastTree());

            // Step 4: Execute the ML Pipeline
            var model = pipeline.Fit(trainTestData.TrainSet);

            var prediction = model.Transform(trainTestData.TestSet);

            // Step 5: evauate the model with test data, returns metrics like precion, efficiency, recall, mse etc.
            var metrics = context.Regression.Evaluate(prediction);

            // Step 6: happy flow - predict, nfer, forecast, analse, classify, cluster
            var predictionFunc = model.CreatePredictionEngine<SalaryData, SalaryPrediction>(context);

            var salaryPrediction = predictionFunc.Predict(new SalaryData { YearsExperience = 11 });

            Console.WriteLine($"Prediction - {salaryPrediction.PredictedSalary}");
            Console.ReadLine();
        }

        private static IEnumerable<SalaryData> WriteAndReadToDatabase(IEnumerable<SalaryData> fileData)
        {
            var options = new DbContextOptionsBuilder<MLNetExampleContext>()
                            .UseInMemoryDatabase(databaseName: "TestData")
                            .Options;

            using (var context = new MLNetExampleContext(options))
            {
                foreach (var item in fileData)
                {
                    context.Salaries.Add(item);
                }

                var count = context.SaveChanges();

                return context.Salaries.ToList();
            }
        }

        private static IEnumerable<SalaryData> ReadFromFile(string filePath)
        {
            var data = File.ReadAllLines(filePath)
                .Skip(1)
                .Select(l => l.Split(','))
                .Select(i => new SalaryData
                {
                    YearsExperience = float.Parse(i[0]),
                    Salary = float.Parse(i[1])
                });

            return data;
        }
    }
}
