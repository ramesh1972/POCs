using System;
using System.IO;
using System.Linq;
using Microsoft.ML;
using Microsoft.ML.Data;

// Define a class to represent the input data
public class InputData
{
     [LoadColumn(0)] public string Label;
    [LoadColumn(1)] public string Text;
}

// Define a class to represent the output data (vectors)
public class OutputData
{
    [VectorType(50)] public float[] Features; // 50 is the dimension of the word vectors
}

class Program
{
    static void Main(string[] args)
    {
        // Create a MLContext
        var mlContext = new MLContext();

        // Read the training data
        var data = mlContext.Data.LoadFromTextFile<InputData>("data.txt", separatorChar: ',');

        // Define the Word Embedding estimator
        var pipeline = mlContext.Transforms.Text
            .FeaturizeText("Features", nameof(InputData.Text))
            .Append(mlContext.Transforms.Conversion.MapValueToKey("Label"))
            .Append(mlContext.Transforms.Conversion.MapKeyToVector("Label"))
            .Append(mlContext.Transforms.NormalizeMinMax("Features"))
            .Append(mlContext.Transforms.Conversion.MapValueToKey("Label"))
            .Append(mlContext.Transforms.Conversion.MapKeyToVector("Label"))
            .Append(mlContext.Transforms.NormalizeMinMax("Features"));

        // Fit the pipeline to the data
        var transformer = pipeline.Fit(data);

        // Transform the data
        var transformedData = transformer.Transform(data);

        // Retrieve the vectors
        var vectors = mlContext.Data.CreateEnumerable<OutputData>(transformedData, reuseRowObject: false)
            .Select(o => o.Features)
            .ToArray();

        // Display the vectors (for demonstration purposes)
        foreach (var vector in vectors)
        {
            Console.WriteLine("------------------");
            Console.WriteLine(string.Join(", ", vector));
        }
    }
}
